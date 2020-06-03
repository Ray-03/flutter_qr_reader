import 'package:flutter/material.dart';
import 'package:qrcode/widgets/logo_text.dart';
import 'package:qrcode/pages/registration_page.dart';
import 'package:qrcode/widgets/text_color_navigation_button.dart';

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
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Logo(),
            SizedBox(
              height: 200,
            ),
            TextColorNavigationButton(
              title: 'Login',
              color: Colors.teal,
              onPressed: () {
//                Navigator.pushNamed(context, HomePage.id);
              },
            ),
            TextColorNavigationButton(
              title: 'Register',
              color: Colors.green,
              onPressed: () {
                Navigator.pushNamed(context, RegistrationPage.id);
              },
            ),
            SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
