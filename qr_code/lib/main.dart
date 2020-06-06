import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qrcode/pages/login_page.dart';
import 'package:qrcode/pages/profile_page.dart';
import 'pages/home_page.dart';
import 'pages/registration_page.dart';
import 'pages/welcome_page.dart';
import 'pages/generate_page.dart';
import 'pages/scanner_page.dart';

void main() => runApp(MyQRApp());

class MyQRApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: 'QR_Profiler',
      theme: ThemeData.dark(),
      home: LandingPage(),
      routes: {
        WelcomePage.id: (context) => WelcomePage(),
        RegistrationPage.id: (context) => RegistrationPage(),
        LoginPage.id: (context) => LoginPage(),
        HomePage.id: (context) => HomePage(),
        ScanPage.id: (context) => ScanPage(),
        GeneratePage.id: (context) => GeneratePage(),
        ProfilePage.id: (context) => ProfilePage(),
      },
    );
  }

//  Widget _getLandingPage() {
//    return StreamBuilder<FirebaseUser>(
//      stream: FirebaseAuth.instance.onAuthStateChanged,
//      builder: (context, snapshot) {
////        return snapshot.hasData ? HomePage() : WelcomePage();
//        if (snapshot.connectionState == ConnectionState.active) {
//          FirebaseUser user = snapshot.data;
//          if (user == null) {
//            return WelcomePage();
//          }
//          return HomePage();
//        } else {
//          return Scaffold(
//            body: CircularProgressIndicator(),
//          );
//        }
//      },
//    );
//  }
}

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          FirebaseUser user = snapshot.data;
          if (user == null) return WelcomePage();
          return HomePage();
        } else
          return Scaffold(
            body: CircularProgressIndicator(),
          );
      },
    );
  }
}
