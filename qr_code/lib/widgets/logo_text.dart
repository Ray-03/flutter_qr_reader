import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TypewriterAnimatedTextKit(
      text: ['QR_Profiler'],
      speed: Duration(milliseconds: 300),
      textAlign: TextAlign.center,
      textStyle: TextStyle(
        color: Colors.tealAccent,
        fontSize: 40,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
