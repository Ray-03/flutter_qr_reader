import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:qrcode/constants.dart';
import 'package:qrcode/home_page.dart';
import 'package:qrcode/logo_text.dart';
import 'package:qrcode/text_color_navigation_button.dart';
import 'package:flushbar/flushbar.dart';

class RegistrationPage extends StatefulWidget {
  static const String id = 'registration_page';
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  String email, password;
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
                      print(e);
                      Flushbar(
                        duration: Duration(seconds: 2),
                        padding: EdgeInsets.all(10),
                        borderRadius: 10,
                        backgroundGradient: LinearGradient(
                          colors: [Colors.red.shade500, Colors.red],
                          stops: [0.7, 1],
                        ),
                        boxShadows: [
                          BoxShadow(
                            color: Colors.black45,
                            offset: Offset(3, 3),
                            blurRadius: 3,
                          ),
                        ],
                        dismissDirection: FlushbarDismissDirection.HORIZONTAL,
                        forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
                        title: 'Failed!',
                        message: 'Error',
                      )..show(context);
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
