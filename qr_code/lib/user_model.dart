import 'package:flutter/material.dart';

class UserModel {
  UserModel(
      {this.firstName,
      this.lastName,
      this.email,
      this.password,
      this.weight,
      this.height});
  String firstName, lastName, email, password;
  int height, weight;
}
