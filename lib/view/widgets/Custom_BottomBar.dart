import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Color(0xffCEAC6D),
      unselectedItemColor: Colors.grey,
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      items: [
        _buildNavItem(icon: Icons.home_outlined, label: 'Home', index: 0),
        _buildNavItem(icon: Icons.shopping_cart_outlined, label: 'Order', index: 1),
        _buildNavItem(icon: Icons.favorite_border, label: 'Favorite', index: 2),
        _buildNavItem(icon: Icons.card_giftcard, label: 'Reward', index: 3),
        _buildNavItem(icon: Icons.person_outline, label: 'Profile', index: 4),
      ],
    );
  }

  BottomNavigationBarItem _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    return BottomNavigationBarItem(
      icon: Container(height: 68,width: 64,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: selectedIndex == index ? Color(0xffCEAC6D) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: selectedIndex == index ? Colors.white : Colors.grey,
        ),
      ),
      label: label,
    );
  }
}
