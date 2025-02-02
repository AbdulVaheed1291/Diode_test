import 'package:flutter/material.dart';

class CustomOrderincrementbutton extends StatefulWidget {
  const CustomOrderincrementbutton({super.key});

  @override
  _CounterComponentState createState() => _CounterComponentState();
}

class _CounterComponentState extends State<CustomOrderincrementbutton> {
  int _count = 0;

  void _increment() {
    setState(() {
      _count++;
    });
  }

  void _decrement() {
    setState(() {
      if (_count > 0) {
        _count--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Left container with icon for decrement
        GestureDetector(
          onTap: _decrement,
          child: Container(
            width: 54, // Fixed width of 54px
            height: 36, // Fixed height of 36px
            decoration: BoxDecoration(
              color: Color(0xff356B69), // Container color
              borderRadius: BorderRadius.circular(16), // Border radius of 16px
              border: Border.all(color: Colors.white, width: 2), // White border
            ),
            child: Icon(Icons.remove, color: Colors.white, size: 20), // Adjusted icon size
          ),
        ),
        const SizedBox(width: 10),

        // Middle container displaying count
        Container(
          width: 54, // Fixed width of 54px
          height: 36, // Fixed height of 36px
          decoration: BoxDecoration(
            color: Colors.white, // Container color
            borderRadius: BorderRadius.circular(16), // Border radius of 16px
            border: Border.all(color: Colors.white, width: 2), // White border
          ),
          child: Center(
            child: Text(
              '$_count',
              style: const TextStyle(
                fontSize: 16, // Adjusted font size for better fit
                color: Color(0xff356B69),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),

        // Right container with icon for increment
        GestureDetector(
          onTap: _increment,
          child: Container(
            width: 54, // Fixed width of 54px
            height: 36, // Fixed height of 36px
            decoration: BoxDecoration(
              color: Color(0xff356B69), // Container color
              borderRadius: BorderRadius.circular(16), // Border radius of 16px
              border: Border.all(color: Colors.white, width: 2), // White border
            ),
            child: Icon(Icons.add, color: Colors.white, size: 20), // Adjusted icon size
          ),
        ),
      ],
    );
  }
}
