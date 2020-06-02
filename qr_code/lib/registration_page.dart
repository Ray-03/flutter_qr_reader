import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:qrcode/constants.dart';
import 'package:qrcode/home_page.dart';
import 'package:qrcode/logo_text.dart';
import 'package:qrcode/text_color_navigation_button.dart';

class RegistrationPage extends StatefulWidget {
  static const String id = 'registration_page';
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  String email, password;
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
                Logo(),
                SizedBox(
                  height: 50,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (newValue) {
                    email = newValue;
                  },
                  decoration: kTextFieldDecor.copyWith(
                      hintText: 'Enter valid email address'),
                ),
                SizedBox(height: 30),
                TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (newValue) {
                    password = newValue;
                  },
                  decoration:
                      kTextFieldDecor.copyWith(hintText: 'Enter password'),
                ),
                SizedBox(
                  height: 40,
                ),
                TextColorNavigationButton(
                  title: 'Register Now!',
                  color: Colors.green,
                  onPressed: () {
                    Navigator.pushNamed(context, HomePage.id);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
