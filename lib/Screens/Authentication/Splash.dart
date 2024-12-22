import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Provider/LoginProvider.dart';
import 'Login.dart';
import '../Main/MainScreen.dart';

String finalNum = '';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();


  }

  void _checkLoginStatus() async {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);

    await Future.delayed(const Duration(seconds: 2)); // Splash delay

    if (loginProvider.number.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    }
  }


  /*Future<void> _checkLoginStatus() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? savedNumber = sharedPreferences.getString('number');

    // If 'number' exists, navigate to MainScreen; otherwise, go to Login
    if (savedNumber != null && savedNumber.isNotEmpty) {
      _navigateToMainScreen();
    } else {
      _navigateToLogin();
    }
  }

  void _navigateToMainScreen() {
    Future.delayed(const Duration(milliseconds: 2000), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()), // Replace with your MainScreen
      );
    });
  }

  void _navigateToLogin() {
    Future.delayed(const Duration(milliseconds: 2000), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
    });
  }*/

  /*void _navigateToLogin() {
    // แสดง Splash Screen เป็นเวลา 3 วินาที
    Future.delayed(const Duration(milliseconds: 2000), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 16),
            const Text(
              'Welcome to University list',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
