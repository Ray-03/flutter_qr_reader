import 'package:flutter/material.dart';
import 'package:qrcode/pages/login_page.dart';
import 'pages/home_page.dart';
import 'pages/registration_page.dart';
import 'pages/welcome_page.dart';
import 'pages/generate_page.dart';
import 'pages/scanner_page.dart';

void main() => runApp(MyQRApp());

class MyQRApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      initialRoute: WelcomePage.id,
      routes: {
        WelcomePage.id: (context) => WelcomePage(),
        RegistrationPage.id: (context) => RegistrationPage(),
        LoginPage.id: (context) => LoginPage(),
        HomePage.id: (context) => HomePage(),
        ScanPage.id: (context) => ScanPage(),
        GeneratePage.id: (context) => GeneratePage(),
      },
    );
  }
}
