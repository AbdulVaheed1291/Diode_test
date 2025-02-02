import 'package:diode_test/view/mainpages/profilepages/Profile_Page.dart';
import 'package:diode_test/view/mainpages/favoritepages/Favorite_Page.dart';
import 'package:diode_test/view/mainpages/orderpages/OrderPage_.dart';
import 'package:diode_test/view/mainpages/rewardpages/Rewards_Page.dart';
import 'package:flutter/material.dart';
import '../../widgets/Custom_BottomBar.dart';
import 'Home.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  /// Returns the selected page based on the bottom navigation index
  Widget _getSelectedPage() {
    switch (_selectedIndex) {
      case 0:
        return const Home(); // Replace with actual home screen widget
      case 1:
        return const OrderAndCartPage();
      case 2:
        return const FavoritePage();
      case 3:
        return const RewardsPage();
      default:
        return const ProfilePage(); // Default page
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      body: _getSelectedPage(), // Dynamically switch between pages
    );
  }
}
