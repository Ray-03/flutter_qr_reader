import 'package:flutter/material.dart';
import 'package:qrcode/generate_page.dart';
import 'package:qrcode/home_page.dart';
import 'package:qrcode/registration_page.dart';
import 'package:qrcode/scanner_page.dart';
import 'package:qrcode/welcome_page.dart';

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
        HomePage.id: (context) => HomePage(),
        ScanPage.id: (context) => ScanPage(),
        GeneratePage.id: (context) => GeneratePage(),
      },
    );
  }
}
