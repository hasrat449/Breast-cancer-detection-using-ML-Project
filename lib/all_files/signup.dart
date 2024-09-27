import 'package:flutter/material.dart';
// Import the LoginScreen

class SignupScreen extends StatelessWidget {
  // Color codes
  Color bannerColor = const Color(0xFFfde4d2); // Your banner color
  Color overallBackgroundColor = const Color(0xFFFFF7D9);

  SignupScreen({super.key}); // Your overall background color

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        title: const Text('Signup Page',style: TextStyle(color: Colors.black,)),
        backgroundColor: bannerColor,
      ),
      body: Container(
        color: overallBackgroundColor,
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
              'Signup Page',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20.0),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Full Name',
              ),
            ),
            const SizedBox(height: 10.0),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 10.0),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 10.0),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Address',
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: bannerColor,
              ),
              onPressed: () {
                // Add login logic here
                Navigator.pushReplacementNamed(context, '/login'); // Corrected route name
              },
              child: const Text('Signup', style: TextStyle(color: Colors.black),),
            ),
            const SizedBox(height: 10.0),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, '/login'); // Navigate to login page
              },
              child: const Text(
                'Already have an account? Login',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
