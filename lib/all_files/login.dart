import 'package:flutter/material.dart';
// Import the SignupScreen

class LoginScreen extends StatelessWidget {
  // Color codes
  Color overallBackgroundColor = const Color(0xFFFFF7D9); // Your overall background color
  Color loginButtonAndBannerColor = const Color(0xFFfde4d2);

  LoginScreen({super.key}); // Your desired button and banner color

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page',style: TextStyle(color: Colors.black,)),
        backgroundColor: loginButtonAndBannerColor,

      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/NHE.png',
              width: 100.0,
              height: 100.0,
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Login Page',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20.0),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Email/Username',
              ),
            ),
            const SizedBox(height: 10.0),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: loginButtonAndBannerColor,
              ),
              onPressed: () {
                // Add login logic here
                Navigator.pushReplacementNamed(context, '/home_screen'); // Corrected route name
              },
              child: const Text('Login', style: TextStyle(color: Colors.black),),

            ),
            const SizedBox(height: 10.0),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/signup'); // Corrected route name
              },
              child: const Text(
                'Create a new account',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,

                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: overallBackgroundColor,
    );
  }
}
