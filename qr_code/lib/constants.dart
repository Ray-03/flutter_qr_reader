import 'package:flutter/material.dart';

const kTextFieldTitle = TextStyle(fontSize: 20);

const kTextFieldDecor = InputDecoration(
  hintText: 'Enter value',
  hintStyle: TextStyle(
    color: Colors.white,
  ),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.lightBlueAccent,
      width: 1.0,
    ),
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(32.0),
      bottomRight: Radius.circular(32.0),
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
    borderRadius: BorderRadius.all(
      Radius.circular(32.0),
    ),
  ),
);
