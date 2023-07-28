// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hostel_attendence_admin/gen/assets.gen.dart';
import 'package:lottie/lottie.dart';
import '../bottom_nav/bottom_navigation.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    _checkCurrentUser();
  }

  // Function to check if the user is logged in
  Future<void> _checkCurrentUser() async {
    final user = _auth.currentUser;
    await Future.delayed(const Duration(seconds: 2)); // Simulate loading time (optional)
    if (user != null) {
      // User is logged in, navigate to Home screen
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MyBottomNavigationBar()),
      );
    } else {
      // User is not logged in, navigate to Login screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(child: LottieBuilder.asset(Assets.lottie.lottieSplash)),
    );
  }
}