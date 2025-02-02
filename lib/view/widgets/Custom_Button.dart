import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final double? width; // Optional width parameter
  final double widthFactor; // Factor of screen width (e.g., 0.8 for 80%)
  final double height; // Fixed height
  final double fontSize; // Base font size
  final Color color;
  final Color textColor;
  final double borderRadius;
  final FontWeight? fontWeight; // Optional fontWeight parameter
  final VoidCallback? onPressed; // Optional callback for button press

  const CustomButton({
    Key? key,
    required this.text,
    this.width, // Optional width parameter
    this.widthFactor = 0.8, // Default to 80% of screen width
    this.height = 45.0,
    this.fontSize = 20.0,
    this.color = const Color(0xff4FC7B1),
    this.textColor = Colors.black,
    this.borderRadius = 10.0,
    this.fontWeight, // Optional fontWeight parameter
    this.onPressed, // Optional callback parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Responsive width based on screen width
    double buttonWidth = width ?? screenWidth * widthFactor;

    // Adjust font size based on screen width
    double adjustedFontSize = fontSize * (screenWidth / 375); // 375 is the base screen width (common for mobile)

    // Adjust height based on screen height, if necessary (e.g., for larger screens)
    double adjustedHeight = height * (screenHeight / 800); // 800 is a typical height for standard screens

    return ElevatedButton(
      onPressed: onPressed, // Pass the callback (can be null)
      style: ElevatedButton.styleFrom(
        foregroundColor: textColor,
        backgroundColor: color, // Button color
        elevation: 2, // Optional elevation
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius), // Rounded corners
        ),
        minimumSize: Size(buttonWidth, adjustedHeight), // Button dimensions
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: fontWeight ?? FontWeight.w700, // Default FontWeight
          fontSize: adjustedFontSize.clamp(16.0, 24.0), // Clamp font size
          color: textColor,
        ),
      ),
    );
  }
}