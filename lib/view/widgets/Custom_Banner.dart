import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BannerCarousel extends StatefulWidget {
  final List<String> banners; // Accept a list of image links

  const BannerCarousel({
    super.key,
    required this.banners, // Make banners a required parameter
  });

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  final PageController _pageController = PageController(
    viewportFraction: 0.9, // Adjust for desired spacing between items
  );
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      int next = _pageController.page!.round();
      if (_currentPage != next) {
        setState(() {
          _currentPage = next;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size for responsiveness
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Dynamically calculate viewport fraction and margins based on screen width
    double viewportFraction = screenWidth > 600 ? 0.7 : 0.85; // Adjust for larger screens (e.g., tablets) and smaller ones (e.g., phones)
    double margin = screenWidth * 0.03; // Dynamic margin based on screen width
    double carouselHeight = screenHeight * 0.25; // Adjust the height based on screen height

    return SizedBox(
      height: carouselHeight, // Set height dynamically
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.banners.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: margin), // Adjust margin
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                widget.banners[index], // Use the passed banners list
                fit: BoxFit.cover, // Adjust how the image is fitted
              ),
            ),
          );
        },
      ),
    );
  }
}
