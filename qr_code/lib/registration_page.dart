import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class RegistrationPage extends StatefulWidget {
  static const String id = 'registration_page';
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: loading,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  child: TypewriterAnimatedTextKit(
                    text: ['QR_Profiler'],
                    speed: Duration(milliseconds: 300),
                    textAlign: TextAlign.center,
                    textStyle: TextStyle(
                      color: Colors.tealAccent,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
