import 'package:flutter/material.dart';

class ThinLine extends StatelessWidget {
  final double lineWidth;

  const ThinLine({
    Key? key,
    required this.lineWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1, // Thin line
      width: lineWidth, // Line width passed as parameter
      color: Colors.white54, // Fixed white color
    );
  }
}
