import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';

class NotificationFlushBar extends StatelessWidget {
  NotificationFlushBar({this.title, this.message, this.error});
//  final Color color1;
//  final Color color2;

  final String title;
  final String message;
  final bool error;
  @override
  Widget build(BuildContext context) {
    return Flushbar(
      duration: Duration(seconds: 2),
      padding: EdgeInsets.all(10),
      borderRadius: 10,
      backgroundGradient: LinearGradient(
        colors: error
            ? [Colors.red.shade500, Colors.redAccent.shade100]
            : [Colors.green.shade500, Colors.greenAccent],
        stops: [0.7, 1],
      ),
      boxShadows: [
        BoxShadow(
          color: Colors.black45,
          offset: Offset(3, 3),
          blurRadius: 3,
        ),
      ],
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      title: title,
      message: message,
    )..show(context);
  }
}
