import 'package:flutter/material.dart';
import 'package:qrcode/pages/generate_page.dart';
import 'package:qrcode/pages/scanner_page.dart';

class HomePage extends StatelessWidget {
  static String id = 'homePage';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('My QR Code'),
          centerTitle: true,
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            IconTitleButton(
              logo: Icons.camera_enhance,
              nav: ScanPage.id,
              title: 'Scan QR',
            ),
            IconTitleButton(
              logo: Icons.create,
              nav: GeneratePage.id,
              title: 'Generate QR',
            ),
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
