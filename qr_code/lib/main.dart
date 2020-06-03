import 'package:flutter/material.dart';
import 'file:///C:/allData/flutter_proj/campus/QRCode/qr_code/lib/pages/generate_page.dart';
import 'file:///C:/allData/flutter_proj/campus/QRCode/qr_code/lib/pages/home_page.dart';
import 'file:///C:/allData/flutter_proj/campus/QRCode/qr_code/lib/pages/registration_page.dart';
import 'file:///C:/allData/flutter_proj/campus/QRCode/qr_code/lib/pages/scanner_page.dart';
import 'file:///C:/allData/flutter_proj/campus/QRCode/qr_code/lib/pages/welcome_page.dart';

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
