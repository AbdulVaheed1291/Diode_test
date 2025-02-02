import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../../view/mainpages/orderpages/Orderitem.dart';
import '../../../view/widgets/Custom_snakebar.dart';

part 'productorder_state.dart';

class ProductorderCubit extends Cubit<ProductorderState> {
  ProductorderCubit(this.context) : super(ProductorderInitial()) {
    loadOrders(); // Load orders when cubit is initialized
  }

  final BuildContext context;
  List<OrderItem> _orders = [];

  // Get current orders
  List<OrderItem> get orders => _orders;

  // Load orders from SharedPreferences
  Future<void> loadOrders() async {
    try {
      print("loading order..........👽👽👽👽👽👽👽👽👽");
      emit(ProductorderLoading());
      final prefs = await SharedPreferences.getInstance();
      final String? ordersJson = prefs.getString('orders');

      if (ordersJson != null) {
        final List<dynamic> decodedOrders = json.decode(ordersJson);
        _orders = decodedOrders.map((item) => OrderItem.fromJson(item)).toList();
      }

      emit(ProductorderLoaded(_orders));
    } catch (e) {
      emit(ProductorderError('Failed to load orders: ${e.toString()}'));
    }
  }

  // Add new order
  Future<void> addOrder({
    required String name,
    required String price,
    required String imageUrl,
  }) async {
    try {
      print("adding order..........👽👽👽👽👽👽👽👽👽");
      final newOrder = OrderItem(
        id: DateTime.now().toString(),
        name: name,
        price: price,
        date: DateFormat('dd-MM-yyyy').format(DateTime.now()),
        time: DateFormat('hh:mm a').format(DateTime.now()),
        status: 'Order placed',
        imageUrl: imageUrl,
      );

      _orders.insert(0, newOrder); // Add at the beginning of the list
      await _saveOrders();

      emit(ProductorderLoaded(_orders));

      showCustomSnackBar(context,message:"Added to cart" );
    } catch (e) {
      emit(ProductorderError('Failed to add order: ${e.toString()}'));
    }
  }

  // Save orders to SharedPreferences
  Future<void> _saveOrders() async {
    try {
      print("saving order..........👽👽👽👽👽👽👽👽👽");
      final prefs = await SharedPreferences.getInstance();
      final String ordersJson = json.encode(_orders.map((e) => e.toJson()).toList());
      await prefs.setString('orders', ordersJson);
    } catch (e) {
      emit(ProductorderError('Failed to save orders: ${e.toString()}'));
    }
  }

  // Update order status
  Future<void> updateOrderStatus(String orderId, String newStatus) async {
    try {
      print("updating order..........👽👽👽👽👽👽👽👽👽");
      final orderIndex = _orders.indexWhere((order) => order.id == orderId);
      if (orderIndex != -1) {
        final updatedOrder = OrderItem(
          id: _orders[orderIndex].id,
          name: _orders[orderIndex].name,
          price: _orders[orderIndex].price,
          date: _orders[orderIndex].date,
          time: _orders[orderIndex].time,
          status: newStatus,
          imageUrl: _orders[orderIndex].imageUrl,
        );

        _orders[orderIndex] = updatedOrder;
        await _saveOrders();
        emit(ProductorderLoaded(_orders));
      }
    } catch (e) {
      emit(ProductorderError('Failed to update order status: ${e.toString()}'));
    }
  }

  // Remove order
  Future<void> removeOrder(String orderId) async {
    try {
      print("removing order..........👽👽👽👽👽👽👽👽👽");
      _orders.removeWhere((order) => order.id == orderId);
      await _saveOrders();
      emit(ProductorderLoaded(_orders));

      showCustomSnackBar(context,message:'Removed Successfully' );
    } catch (e) {
      emit(ProductorderError('Failed to remove order: ${e.toString()}'));
    }
  }

  // Search orders
  void searchOrders(String query) {
    try {
      print("searching order..........👽👽👽👽👽👽👽👽👽");
      if (query.isEmpty) {
        emit(ProductorderLoaded(_orders));
        return;
      }

      final filteredOrders = _orders.where((order) =>
      order.name.toLowerCase().contains(query.toLowerCase()) ||
          order.status.toLowerCase().contains(query.toLowerCase())
      ).toList();

      emit(ProductorderLoaded(filteredOrders));
    } catch (e) {
      emit(ProductorderError('Failed to search orders: ${e.toString()}'));
    }
  }
}