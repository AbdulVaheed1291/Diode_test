import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:diode_test/view/widgets/Custom_Text.dart';

class RewardsPage extends StatefulWidget {
  const RewardsPage({super.key});

  @override
  State<RewardsPage> createState() => _RewardsPageState();
}

class _RewardsPageState extends State<RewardsPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
    ));

    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.3, 0.8, curve: Curves.easeOut),
    ));

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
    ));

    // Start animation loop
    _controller.forward().then((_) {
      Future.delayed(const Duration(seconds: 1), () {
        _controller.repeat(reverse: true);
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Dynamically calculate font size based on screen width
    double headerFontSize = screenWidth * 0.05; // 5% of screen width
    double bodyFontSize = screenWidth * 0.045; // 4.5% of screen width
    double smallFontSize = screenWidth * 0.04; // 4% of screen width

    // Dynamically adjust image size based on screen width
    double imageWidth = screenWidth * 0.6; // 60% of screen width

    return Scaffold(
      body: Column(
        children: [
          // Header section with no animation
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 80,
                child: Image.asset(
                  'assets/Rectangle 1 (1).png',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Image.asset(
                  'assets/Frame 7 (1).png',
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 40,
                left: 20,
                right: 20,
                child: Text(
                  "Rewards and offers",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: headerFontSize,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.07),

          // Animated content
          FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                children: [
                  TextWidget(
                    text: "Congratulations!",
                    color: Color(0xffCEAC6D),
                    fontWeight: FontWeight.w600,
                    fontSize: headerFontSize,
                  ),
                  TextWidget(
                    text: "You are now upgraded to Gold Tier!!",
                    color: Color(0xff6E8382),
                    fontWeight: FontWeight.w500,
                    fontSize: bodyFontSize,
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: screenHeight * 0.07),

          // Animated Frame image
          ScaleTransition(
            scale: _scaleAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Image.asset("assets/Frame.png", width: imageWidth),
            ),
          ),

          SizedBox(height: screenHeight * 0.04),

          // Animated text
          FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: TextWidget(
                text: "Access Loyalty Tier benefits and\nredeem it with ease",
                color: Color(0xff6E8382),
                fontWeight: FontWeight.w500,
                fontSize: smallFontSize,
              ),
            ),
          ),

          SizedBox(height: screenHeight * 0.04),

          // Animated bottom images with delayed animation
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, 50 * (1 - _controller.value)),
                child: Opacity(
                  opacity: _controller.value,
                  child: Column(
                    children: [
                      Image.asset("assets/Frame 27.png", width: imageWidth),
                      SizedBox(height: screenHeight * 0.04),
                      Image.asset("assets/Frame 25.png", width: imageWidth),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
