import 'package:flutter/material.dart';

class CustomCont extends StatefulWidget {
  final String text;
  final int width;
  final FontWeight? fontWeight;
  final double? fontSize;

  const CustomCont({
    Key? key,
    required this.text,
    this.fontWeight,
    this.fontSize,
    required this.width,
  }) : super(key: key);

  @override
  _CustomContState createState() => _CustomContState();
}

class _CustomContState extends State<CustomCont> {
  bool _isTapped = false; // To track whether the container is tapped

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isTapped = !_isTapped; // Toggle the tap state
        });
      },
      child: Container(
        width: widget.width.toDouble(),
        height: 24,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white, // White border
            width: 2, // Adjust the width of the border as needed
          ),
          color: _isTapped ? Colors.white : Colors.transparent, // Change background color on tap
        ),
        child: Center(
          child: Text(
            widget.text,
            style: TextStyle(
              fontSize: widget.fontSize,
              fontWeight: widget.fontWeight,
              color: _isTapped ? Color(0xff356B69) : Colors.white, // Change text color on tap
            ),
          ),
        ),
      ),
    );
  }
}
