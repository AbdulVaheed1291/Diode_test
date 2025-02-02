import 'package:flutter/material.dart';

class TrendingItemCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String? description; // Optional field
  final String? userRating; // Optional field
  final String? duration; // Optional field
  final String? cost; // Optional field

  const TrendingItemCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    this.description,
    this.userRating,
    this.duration,
    this.cost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 176,
      height: 196,
      child: Card(
        elevation: 4.0,
        margin: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 90.0, // Reduced image height
            ),
            Padding(
              padding: const EdgeInsets.all(6.0), // Reduced padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14.0, // Reduced font size
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2.0), // Reduced spacing
                  if (userRating != null || duration != null) ...[
                    Row(
                      children: [
                        if (userRating != null) ...[
                          const Icon(Icons.star, color: Colors.amber, size: 12.0),
                          Text(
                            userRating!,
                            style: const TextStyle(fontSize: 10.0), // Reduced font size
                          ),
                          const SizedBox(width: 74.0), // Reduced spacing
                        ],
                        if (duration != null) ...[
                          const Icon(Icons.access_time, color: Colors.grey, size: 12.0),
                          Text(
                            duration!,
                            style: const TextStyle(fontSize: 10.0), // Reduced font size
                          ),
                        ],
                      ],
                    ),
                  ],
                  const SizedBox(height: 4.0), // Reduced spacing
                  if (cost != null) ...[
                    Text(
                      cost!,
                      style: const TextStyle(
                        fontSize: 12.0, // Reduced font size
                        fontWeight: FontWeight.bold,
                        color:Color(0xffCEAC6D),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
