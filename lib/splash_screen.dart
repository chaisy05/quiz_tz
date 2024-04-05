import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quiz_tz/quiz_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => QuizScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Famous Scientists',
          style: TextStyle(fontSize: 24.0, color: Colors.black),
        ),
      ),
    );
  }
}
