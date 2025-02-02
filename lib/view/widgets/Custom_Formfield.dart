import 'package:flutter/material.dart';

Widget customTextFormField({
  required TextEditingController controller,
  String hintText = '',
  TextInputType keyboardType = TextInputType.text,
  bool obscureText = false,
  IconData? prefixIcon,
  IconData? suffixIcon,
  VoidCallback? onSuffixTap,
  bool isEmailField = false, // To identify if this is the email field
  bool isPasswordField = false, // To identify if this is the password field
}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    obscureText: obscureText,
    validator: (value) {
      if (isEmailField && value != 'admin') {
        return 'Email must be "admin"';
      }
      if (isPasswordField && value != 'password') {
        return 'Password must be "password"';
      }
      return null; // No error
    },
    decoration: InputDecoration(
      hintText: hintText,
      filled: true,
      fillColor: Colors.white,
      prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
      suffixIcon: suffixIcon != null
          ? GestureDetector(
        onTap: onSuffixTap,
        child: Icon(suffixIcon),
      )
          : null,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.blue),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.red),
      ),
      errorStyle: TextStyle(color: Colors.red), // User-friendly error message style
    ),
  );
}