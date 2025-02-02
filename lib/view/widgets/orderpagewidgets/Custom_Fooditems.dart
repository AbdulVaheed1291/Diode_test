import 'package:flutter/material.dart';

class FoodItems extends StatelessWidget {
  final String imagePath;
  final String name;

  const FoodItems({
    Key? key,
    required this.imagePath,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(imagePath),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class ItemGrid extends StatelessWidget {
  final List<Map<String, String>> items;

  const ItemGrid({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return FoodItems(
          imagePath: items[index]['imagePath']!,
          name: items[index]['name']!,
        );
      },
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Coffee Items'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Cold Brew',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ItemGrid(
                  items: [
                    // {'imagePath': 'assets/arabica_beans.png', 'name': 'Arabica Beans'},
                    // {'imagePath': 'assets/cheesecake.png', 'name': 'Cheesecake'},
                    // {'imagePath': 'assets/croissants.png', 'name': 'Croissants'},
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  'Mocha',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ItemGrid(
                  items: [
                    // {'imagePath': 'assets/americano.png', 'name': 'Americano'},
                    // {'imagePath': 'assets/espresso.png', 'name': 'Espresso'},
                    // {'imagePath': 'assets/tiramisu.png', 'name': 'Tiramisu'},
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}