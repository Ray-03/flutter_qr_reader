import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GeneratePage extends StatefulWidget {
  static String id = 'generate';
  @override
  _GeneratePageState createState() => _GeneratePageState();
}

class _GeneratePageState extends State<GeneratePage> {
  String value = 'https://www.qrcode.com/en/history/';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Generate QR Code'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            TextField(
              onChanged: (String newValue) {
                setState(() {
                  value = newValue;
                });
              },
              autofocus: true,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                icon: Icon(Icons.title),
                hintText: 'Put your link here and convert to QR',
              ),
            ),
            Container(
              padding: EdgeInsets.all(75),
              child: Center(
                child: Stack(
                  alignment: Alignment(0, 0),
                  children: [
                    Container(
                      width: 198,
                      height: 198,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                          colors: [Colors.blueAccent, Colors.blue],
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          stops: [0, 1],
                        ),
                      ),
                    ),
                    Container(
                      width: 189,
                      height: 189,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                    ),
                    QrImage(
                      data: value,
                      size: 198,
                      version: QrVersions.auto,
                      gapless: true,
                      constrainErrorBounds: true,
                      embeddedImageStyle:
                          QrEmbeddedImageStyle(size: Size(80, 80)),
                      errorCorrectionLevel: QrErrorCorrectLevel.Q,
                      errorStateBuilder: (context, err) {
                        return Container(
                          child: Text(
                            'ummm... something went wrong',
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                    ),
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      width: 53,
                      height: 53,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                            colors: [
                              Colors.cyan.shade100,
                              Colors.lightBlueAccent.shade100
                            ],
                            stops: [
                              0,
                              1
                            ],
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft),
                      ),
                      child: Image.asset('images/logoBINUS.png'),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
