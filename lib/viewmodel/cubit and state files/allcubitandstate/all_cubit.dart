import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../model/apimodels/Api_Model.dart';
import 'all_state.dart';
import 'package:http/http.dart' as http;

class AllCubit extends Cubit<AllState> {
  AllCubit(this.context) : super(AllInitial()) {
    _loadProductsFromSharedPreferences();
  }

  BuildContext context;
  final String baseUrl = "https://mt.diodeinfosolutions.com/api";

  Future<void> getProducts() async {
    emit(AllLoading());

    try {
      // Get the auth token from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? authToken = prefs.getString("auth_token");

      if (authToken == null || authToken.isEmpty) {
        print("🔑 Auth Token Missing: Token is ${authToken == null ? 'null' : 'empty'}");
        emit(AllFailure("Authentication required. Please log in again."));
        return;
      }

      print("🔑 Using Auth Token: $authToken");

      final response = await http.get(
        Uri.parse("$baseUrl/get-products"),
        headers: {
          "Authorization": " $authToken",
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      ).timeout(
        const Duration(seconds: 15), // Add timeout
        onTimeout: () {
          throw TimeoutException("Request timed out");
        },
      );

      print("📡 API Response Status: ${response.statusCode}");
      print("📦 API Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);

        if (responseData.isEmpty) {
          print("📝 API returned empty product list");
          emit(AllSuccess([]));
          return;
        }

        List<Product> products = [];
        for (var productData in responseData) {
          try {
            products.add(Product.fromJson(productData));
          } catch (e) {
            print("⚠️ Error parsing product: $e");
            print("⚠️ Problematic product data: $productData");
            // Continue with next product instead of failing completely
            continue;
          }
        }

        if (products.isNotEmpty) {
          await _saveProductsToSharedPreferences(products);
          emit(AllSuccess(products));
        } else {
          emit(AllFailure("No valid products found in response"));
        }
      } else if (response.statusCode == 401) {
        print("🚫 Authentication failed: ${response.body}");
        // Clear invalid token
        await prefs.remove("auth_token");
        emit(AllFailure("Session expired. Please log in again."));
      } else {
        print("❌ API Error: Status ${response.statusCode}, Body: ${response.body}");
        emit(AllFailure("Server error: ${response.statusCode}"));
      }
    } on TimeoutException {
      print("⏰ Request timed out");
      emit(AllFailure("Connection timed out. Please try again."));
    } catch (e, stackTrace) {
      print("💥 Error: $e");
      print("Stack trace: $stackTrace");

      // Check if it's a FormatException (invalid JSON)
      if (e is FormatException) {
        emit(AllFailure("Invalid response format from server"));
      } else {
        emit(AllFailure("Unexpected error occurred. Please try again."));
      }
    }
  }

  Future<void> _saveProductsToSharedPreferences(List<Product> products) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> productJsonList = products
          .map((product) => jsonEncode(product.toJson()))
          .toList();
      await prefs.setStringList("products", productJsonList);
      print("💾 Saved ${products.length} products to SharedPreferences");
    } catch (e) {
      print("❌ Error saving to SharedPreferences: $e");
    }
  }

  Future<void> _loadProductsFromSharedPreferences() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? productJsonList = prefs.getStringList("products");

      if (productJsonList != null && productJsonList.isNotEmpty) {
        List<Product> products = [];
        for (var jsonString in productJsonList) {
          try {
            products.add(Product.fromJson(jsonDecode(jsonString)));
          } catch (e) {
            print("⚠️ Error parsing cached product: $e");
            continue;
          }
        }

        if (products.isNotEmpty) {
          print("📱 Loaded ${products.length} products from cache");
          emit(AllSuccess(products));
        } else {
          print("🔄 No valid cached products, fetching from API");
          getProducts();
        }
      } else {
        print("🔄 No cached products, fetching from API");
        getProducts();
      }
    } catch (e) {
      print("❌ Error loading from SharedPreferences: $e");
      getProducts();
    }
  }
}

class TimeoutException implements Exception {
  final String message;
  TimeoutException(this.message);

  @override
  String toString() => message;
}