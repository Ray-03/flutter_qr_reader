import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flushbar/flushbar.dart';
import 'dart:async';

import 'package:qrcode/notification_flush_bar.dart';

class ScanPage extends StatefulWidget {
  static String id = 'scan';
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  String result = 'Hello there >.<';

  Future scanner() async {
    String input;
    try {
      input = await BarcodeScanner.scan();
      setState(() => result = input);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() => result = 'I need your camera permission :(');
      } else {
        setState(() => result = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => result = 'You pressed back button before scan');
    } catch (e) {
      setState(() => result = 'Unknown error: $e');
    }
  }

  void showCopiedFlushbar(BuildContext context) {
    NotificationFlushBar(
      error: false,
      title: 'Success!',
      message: 'Copied to your clipboard',
    ).build(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Scan QR Code'),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: SelectableText(
                result,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
            SizedBox(
              height: 120,
            ),
            Divider(
              color: Colors.white,
              thickness: 2,
              indent: 20,
              endIndent: 20,
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 50.0,
                vertical: 30.0,
              ),
              child: RaisedButton(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Copy to Clipboard',
                  style: TextStyle(fontSize: 30.0),
                ),
                color: Colors.cyan,
                onPressed: () {
                  showCopiedFlushbar(context);
                  Clipboard.setData(
                    ClipboardData(text: result),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 50.0,
                vertical: 30.0,
              ),
              child: RaisedButton(
                onPressed: scanner,
                padding: EdgeInsets.all(20.0),
                color: Colors.blue,
                splashColor: Colors.blueGrey,
                child: Text(
                  'Start scan!',
                  style: TextStyle(fontSize: 30.0),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
