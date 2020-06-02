import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  static const String id = 'welcome_page';
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TypewriterAnimatedTextKit(
              text: ['QR_Profiler'],
              speed: Duration(milliseconds: 300),
              textAlign: TextAlign.center,
              textStyle: TextStyle(
                color: Colors.tealAccent,
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
