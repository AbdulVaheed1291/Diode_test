import 'package:flutter/material.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              // Background Image
              Container(
                width: double.infinity,
                height: 128,
                child: Image.asset(
                  'assets/Rectangle 1 (1).png',
                  fit: BoxFit.cover,
                ),
              ),
              // Overlay Image
              Positioned(
                top: 0, // Position it at the top of the first image
                left: 0,
                right: 0,
                child: Image.asset(
                  'assets/Frame 7 (1).png',
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
