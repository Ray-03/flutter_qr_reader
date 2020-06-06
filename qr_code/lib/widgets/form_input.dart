import 'package:flutter/material.dart';
import 'package:qrcode/constants.dart';

class FormInput extends StatelessWidget {
  FormInput({
//    @required this.title,
    this.hint,
    this.inputType = TextInputType.text,
    this.obscure = false,
    this.validator,
    this.onSaved,
  });
  final Function onSaved;
  final Function validator;
  final String hint;
  final bool obscure;
  final TextInputType inputType;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        validator: validator,
        onSaved: onSaved,
        obscureText: obscure,
        keyboardType: inputType,
        textAlign: TextAlign.center,
        decoration: kTextFieldDecor.copyWith(hintText: hint),
      ),
    );
  }
}
