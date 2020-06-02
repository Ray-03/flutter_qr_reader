import 'package:flutter/material.dart';

class TextColorNavigationButton extends StatelessWidget {
  TextColorNavigationButton({this.title, this.color, this.onPressed});
  final Function onPressed;
  final Color color;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42,
          elevation: 5,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 25,
            ),
          ),
        ),
      ),
    );
  }
}
