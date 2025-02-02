import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/Custom_Formfield.dart';
import '../mainpages/Splash_Page.dart';
import '../../viewmodel/cubit and state files/logincubitandstate/login_cubit.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => LoginCubit(context),
      child: Scaffold(
        backgroundColor: const Color(0xff356B69),
        body: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => SplashPage()),
              );
            } else if (state is LoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
          child: BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              final cubit = context.read<LoginCubit>();
              return SingleChildScrollView(
                child: Container(
                  height: screenHeight,
                  child: Stack(
                    children: [
                      // Background Image
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        height: screenHeight * 0.4,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/thumbnail.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),

                      // Logo Overlay
                      Positioned(
                        top: screenHeight * 0.15,
                        left: 0,
                        right: 0,
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/ROAST.png',
                              height: screenHeight * 0.04, // Responsive height
                            ),
                            SizedBox(height: screenHeight * 0.01), // Responsive spacing
                            Image.asset(
                              'assets/COFFEE ROASTERY.png',
                              height: screenHeight * 0.02, // Responsive height
                            ),
                          ],
                        ),
                      ),

                      // Login Form Container
                      Positioned(
                        top: screenHeight * 0.35,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(screenWidth * 0.06), // Responsive padding
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: screenHeight * 0.02), // Responsive spacing
                                Text(
                                  'Welcome Back',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.06, // Responsive font size
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff356B69),
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.01), // Responsive spacing
                                Text(
                                  'Sign in to continue',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.03, // Responsive font size
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.04), // Responsive spacing
                                customTextFormField(
                                  controller: cubit.emailCtr,
                                  hintText: 'Email',
                                  keyboardType: TextInputType.emailAddress,
                                  prefixIcon: Icons.email_outlined,
                                ),
                                SizedBox(height: screenHeight * 0.02), // Responsive spacing
                                customTextFormField(
                                  controller: cubit.passwordCtr,
                                  hintText: 'Password',
                                  obscureText: true,
                                  prefixIcon: Icons.lock_outline,
                                ),
                                SizedBox(height: screenHeight * 0.02), // Responsive spacing
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {
                                      // Add forgot password functionality
                                    },
                                    child: Text(
                                      'Forgot Password?',
                                      style: TextStyle(
                                        color: Color(0xff356B69),
                                        fontSize: screenWidth * 0.03, // Responsive font size
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.04), // Responsive spacing
                                InkWell(
                                  onTap: () {
                                    cubit.login();
                                  },
                                  child: state is LoginLoading
                                      ? Center(
                                    child: CircularProgressIndicator(
                                      color: Color(0xff356B69),
                                    ),
                                  )
                                      : Container(
                                    width: double.infinity,
                                    height: screenHeight * 0.07, // Responsive height
                                    decoration: BoxDecoration(
                                      color: Color(0xff356B69),
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xff356B69).withOpacity(0.3),
                                          blurRadius: 10,
                                          offset: Offset(0, 5),
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Sign In',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: screenWidth * 0.04, // Responsive font size
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}