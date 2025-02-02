import 'package:diode_test/viewmodel/cubit%20and%20state%20files/logincubitandstate/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen width for responsiveness
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    // Set padding and margin based on screen width
    double padding = screenWidth * 0.04; // 4% of screen width for padding
    double margin = screenWidth * 0.04; // 4% of screen width for margin

    return Container(
      padding: EdgeInsets.all(padding),
      margin: EdgeInsets.all(margin),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: BlocProvider(
        create: (context) => LoginCubit(context),
        child: BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            final cubit=context.read<LoginCubit>();
            return Column(
              children: [
                // Wallet Balance
                _buildMenuItem(
                  image: "assets/wallet.png",
                  title: "Wallet Balance",
                  subtitle: "BHD 86.000",
                  showDivider: true,
                  isWallet: true,
                ),

                // Address
                _buildMenuItem(
                  image: "assets/contacts.png",
                  title: "Address",
                  subtitle: "107, Omar Bin Abdulaziz Avenue\nAl Hoora, Manama, Capital\nGovernorate, Bahrain, 0319.",
                  showDivider: true,
                  hasMultilineSubtitle: true,
                ),

                // Privacy Policy
                _buildMenuItem(
                  image: "assets/notes.png",
                  title: "Privacy Policy",
                  showDivider: true,
                  titleColor: Color(0xFFDEB887),
                ),

                // Communication
                _buildMenuItem(
                  image: "assets/message.png",
                  title: "Communication",
                  showDivider: true,
                  titleColor: Color(0xFFDEB887),
                ),

                // About Us
                _buildMenuItem(
                  image: "assets/questionmark.png",
                  title: "About Us",
                  showDivider: true,
                  titleColor: Color(0xFFDEB887),
                ),

                // Rate us
                _buildMenuItem(
                  image: "assets/star.png",
                  title: "Rate us on Google Play Store",
                  showDivider: true,
                  titleColor: Color(0xFFDEB887),
                ),

                // Contact Us
                _buildMenuItem(
                  image: "assets/mail.png",
                  title: "Contact Us",
                  showDivider: true,
                  titleColor: Color(0xFFDEB887),
                ),

                // Logout
            InkWell(
            onTap: () {
            showDialog(
            context: context,
            builder: (BuildContext context) {
            return AlertDialog(
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            ),
            title: Text(
            'Logout',
            style: TextStyle(
            fontWeight: FontWeight.bold,
            ),
            ),
            content: Text(
            'Are you sure you want to logout?',
            style: TextStyle(fontSize: 16),
            ),
            actions: [
            TextButton(
            onPressed: () {
            Navigator.pop(context);
            },
            child: Text(
            'Cancel',
            style: TextStyle(
            color: Colors.grey[600],
            ),
            ),
            ),
            TextButton(
            onPressed: () {
            Navigator.pop(context);
            cubit.logout();
            },
            child: Text(
            'Yes, Logout',
            style: TextStyle(
            color: Color(0xFFDEB887),
            fontWeight: FontWeight.bold,
            ),
            ),
            ),
            ],
            );
            },
            );
            },
                  child: _buildMenuItem(
                    image: "assets/logout.png",
                    title: "Logout",
                    showDivider: false,
                    titleColor: Color(0xFFDEB887),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required String image, // Change to String for correct path
    required String title,
    String? subtitle,
    bool showDivider = true,
    bool isWallet = false,
    bool hasMultilineSubtitle = false,
    Color titleColor = Colors.black87,
  }) {
    return Column(
      children: [
        Material(elevation: 1,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                // Icon with dynamic color
                Image.asset(image), // Fix: Use Image.asset with the path string
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title text
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: titleColor,
                        ),
                      ),
                      if (subtitle != null)
                        Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Text(
                            subtitle,
                            style: TextStyle(
                              fontSize: hasMultilineSubtitle ? 12 : 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                // Arrow icon

              ],
            ),
          ),
        ),
        if (showDivider)
          Divider(
            color: Colors.grey[200],
            thickness: 1,
          ),
      ],
    );
  }
}
