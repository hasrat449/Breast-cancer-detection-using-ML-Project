import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'all_files/login.dart';
import 'all_files/signup.dart';
import 'all_files/splash.dart';
import 'home_screen.dart'; // Import the correct file for HomeScreen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  runApp(MyApp(cameras: cameras));
}

class MyApp extends StatelessWidget {
  final List<CameraDescription> cameras;

  const MyApp({super.key, required this.cameras});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/home_screen': (context) => HomeScreen(cameras: cameras),
      },
    );
  }
}
