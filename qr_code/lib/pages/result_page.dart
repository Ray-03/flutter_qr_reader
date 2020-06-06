import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qrcode/user_model.dart';
import 'package:qrcode/widgets/notification_flush_bar.dart';

class ResultPage extends StatefulWidget {
  ResultPage({this.uid});
  final String uid;
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  final Firestore _firestore = Firestore.instance;
  UserModel _userModel = UserModel();

  Future<UserModel> getUserModel() async {
    DocumentSnapshot ds =
        await _firestore.collection('user').document(widget.uid).get();
    _userModel.email = ds.data['email'];
    _userModel.password = ds.data['password'];
    _userModel.firstName = ds.data['firstName'];
    _userModel.lastName = ds.data['lastName'];
    _userModel.height = ds.data['height'];
    _userModel.weight = ds.data['weight'];
    return _userModel;
  }

  @override
  Widget build(BuildContext context) {
    String result;
    void showCopiedFlushbar(BuildContext context) {
      NotificationFlushBar(
        error: false,
        title: 'Success!',
        message: 'Copied to your clipboard',
      ).build(context);
    }

    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<UserModel>(
          future: getUserModel(),
          builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            result =
                '${snapshot.data.email};${snapshot.data.firstName};${snapshot.data.lastName};${snapshot.data.weight.toString()};${snapshot.data.height.toString()}';
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  snapshot.data.email,
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  snapshot.data.firstName,
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  snapshot.data.lastName,
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  snapshot.data.weight.toString(),
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  snapshot.data.height.toString(),
                  style: TextStyle(fontSize: 20),
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
                      style: TextStyle(fontSize: 20.0),
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
              ],
            );
          },
        ),
      ),
    );
  }
}
