import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qrcode/pages/generate_page.dart';
import 'package:qrcode/pages/profile_page.dart';
import 'package:qrcode/pages/scanner_page.dart';
import 'package:qrcode/user_model.dart';

class HomePage extends StatelessWidget {
  static String id = 'homePage';
  final Firestore _firestore = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: GestureDetector(
                    onTap: () => Navigator.pushNamed(context, ProfilePage.id),
                    child: Icon(
                      Icons.create,
                      color: Colors.greenAccent.shade200,
                      size: 50,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: GestureDetector(
                    onTap: _signOut,
                    child: Icon(
                      Icons.exit_to_app,
                      color: Colors.greenAccent.shade200,
                      size: 50,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconTitleButton(
                  logo: Icons.camera_enhance,
                  nav: ScanPage.id,
                  title: 'Scan QR',
                ),
                IconTitleButton(
                  logo: Icons.account_circle,
                  nav: GeneratePage.id,
                  title: 'Show Profile',
                ),
              ],
            ),
            Container(
              constraints: BoxConstraints.tight(
                Size(50, 50),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class IconTitleButton extends StatelessWidget {
  IconTitleButton({@required this.logo, this.title, this.nav});
  final String nav;
  final IconData logo;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyCustomFAB(
          logo: logo,
          nav: () {
            Navigator.pushNamed(context, nav);
          },
        ),
        Text(
          title,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class MyCustomFAB extends StatelessWidget {
  MyCustomFAB({@required this.logo, @required this.nav});
  final Function nav;
  final IconData logo;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: Colors.tealAccent,
      shape: CircleBorder(),
      elevation: 10.0,
      constraints: BoxConstraints.tightFor(height: 120.0, width: 120.0),
      child: Icon(
        logo,
        size: 75.0,
        color: Colors.black,
      ),
      onPressed: nav,
    );
  }
}
