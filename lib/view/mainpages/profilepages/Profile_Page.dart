import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/profilepagewidgets/Custom_ProfileMenu.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                // Background Image
                Container(
                  width: double.infinity,
                  height: 280,
                  child: Image.asset(
                    'assets/Rectangle 1 (1).png',
                    fit: BoxFit.cover,
                  ),
                ),
                // Overlay Image
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
                // Content Column
                Positioned(
                  top: 30,
                  left: 0,
                  right: 0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Profile Text
                      Text(
                        "Profile",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      // Circle Avatar for profile picture
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage('assets/image 24.png'),
                        ),
                      ),
                      // Name text below the avatar
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          "Admin",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      // Phone number text
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          "+973 56 89 52 41",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade300,
                          ),
                        ),
                      ),
                      // Orders and Rewards Row
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 40, right: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Total Orders
                            Row(
                              children: [
                                Image.asset("assets/Vector (1).png"),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Total Orders",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      "56",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            // Vertical Divider
                            Container(
                              height: 40,
                              width: 1,
                              color: Colors.white.withOpacity(0.3),
                            ),
                            // Reward Points
                            Row(
                              children: [
                                Image.asset("assets/Vector (2).png"),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Reward Points",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      "128",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(children: [SingleChildScrollView(child: ProfileMenu())],)
          ],
        ),
      ),
    );
  }
}
