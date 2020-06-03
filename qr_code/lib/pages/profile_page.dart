import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  static const String id = 'profile_page';
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: AppBar(
          title: Text('Edit Profile'),
          centerTitle: true,
        ),
      ),
    );
  }
}
