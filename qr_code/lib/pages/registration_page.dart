import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qrcode/constants.dart';
import 'package:qrcode/pages/home_page.dart';
import 'package:qrcode/widgets/logo_text.dart';
import 'package:qrcode/widgets/text_color_navigation_button.dart';
import 'package:qrcode/widgets/notification_flush_bar.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationPage extends StatefulWidget {
  static const String id = 'registration_page';
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  String email = '';
  String password = '';
  bool loading = false;
  final _auth = FirebaseAuth.instance;
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
                  onPressed: () async {
                    setState(() {
                      loading = true;
                    });
                    try {
                      final user = await _auth.createUserWithEmailAndPassword(
                          email: email, password: password);
                      if (user != null)
                        Navigator.pushNamed(context, HomePage.id);
                    } catch (e) {
                      print(e.code);
                      String message;
                      switch (e.code) {
                        case 'ERROR_INVALID_EMAIL':
                          message = 'Please input valid email format';
                          break;
                        case 'ERROR_EMAIL_ALREADY_IN_USE':
                          message = 'This mail is already used';
                          break;
                        case 'ERROR_WEAK_PASSWORD':
                          message = 'Password al least contain 6 characters';
                          break;
                        case 'error':
                          message = 'You must fill email and password';
                          break;
                      }
                      NotificationFlushBar(
                        title: 'Oops!',
                        message: message,
                        error: true,
                      ).build(context);
                    }
                    setState(() {
                      loading = false;
                    });
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
