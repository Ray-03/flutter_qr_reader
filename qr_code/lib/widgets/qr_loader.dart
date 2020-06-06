import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRLoad extends StatelessWidget {
  final _auth = FirebaseAuth.instance;

  Future<String> callAsyncFetch() async {
    return (await _auth.currentUser()).uid;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: callAsyncFetch(),
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return QrImage(
              data: snapshot.data,
              size: 198,
              version: QrVersions.auto,
              gapless: true,
              constrainErrorBounds: true,
              embeddedImageStyle: QrEmbeddedImageStyle(size: Size(80, 80)),
              errorCorrectionLevel: QrErrorCorrectLevel.Q,
              errorStateBuilder: (context, err) {
                return Container(
                  child: Text(
                    'ummm... something went wrong',
                    textAlign: TextAlign.center,
                  ),
                );
              },
            );
          } else {
            return CircularProgressIndicator(
              backgroundColor: Colors.blue,
            );
          }
        });
  }
}
