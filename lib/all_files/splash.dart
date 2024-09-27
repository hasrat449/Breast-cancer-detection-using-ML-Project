import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFfde4d2), // Set the background color
      body: Center(
        child: Image.asset(
          'assets/NHE.png',
          fit: BoxFit.cover,
          width: 300, // Set the desired width for the logo image
          height: 300, // Set the desired height for the logo image
        ),
      ),
    );
  }
}