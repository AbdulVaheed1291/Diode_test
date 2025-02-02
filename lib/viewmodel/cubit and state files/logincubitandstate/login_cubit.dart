import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../view/authenticationpages/Login_Page.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.context) : super(LoginInitial());

  final BuildContext context;
  final TextEditingController emailCtr = TextEditingController();
  final TextEditingController passwordCtr = TextEditingController();

  Future<void> login() async {
    emit(LoginLoading());

    final url = Uri.parse("https://mt.diodeinfosolutions.com/api/login");

    try {
      final response = await http.post(
        url,
        body: {
          "username": emailCtr.text.trim(),
          "password": passwordCtr.text.trim(),
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData.containsKey("auth_token")) {
          final String authToken = responseData["auth_token"];
          print("☺️☺️☺️$authToken");

          // Save token & login data to SharedPreferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString("auth_token", authToken);
          await prefs.setString("username", emailCtr.text);
          await prefs.setString("password", passwordCtr.text);

          emit(LoginSuccess(authToken));

          // Navigate to HomePage.dart
        } else {
          emit(LoginFailure("Invalid credentials"));
        }
      } else {
        emit(LoginFailure("Invalid username or password"));
      }
    } catch (e) {
      emit(LoginFailure("$e Login failed. Please try again."));
      print(
          "$e                  hereeeeeeeeeeeeeeeeeeeeeeeeeeeeee......................................");
    }
  }

// Logout function
  Future<void> logout() async {
    try {
      // Clear all saved preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove("auth_token");
      await prefs.remove("username");
      await prefs.remove("password");

      // Emit a logout success state
      emit(LogoutSuccess());

      // Navigate to the login page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                LoginPage()), // Use your actual LoginPage widget
      );
    } catch (e) {
      emit(LogoutFailure(
          "An error occurred while logging out. Please try again."));
    }
  }
}
