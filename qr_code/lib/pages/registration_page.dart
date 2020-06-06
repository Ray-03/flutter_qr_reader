import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qrcode/constants.dart';
import 'package:qrcode/pages/home_page.dart';
import 'package:qrcode/user_model.dart';
import 'package:qrcode/widgets/form_input.dart';
import 'package:qrcode/widgets/logo_text.dart';
import 'package:qrcode/widgets/notification_flush_bar.dart';
import 'package:qrcode/widgets/text_color_navigation_button.dart';
import 'package:validators/validators.dart' as validator;
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationPage extends StatefulWidget {
  static const String id = 'registration_page';
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;
  UserModel _userModel = UserModel();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: _loading,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                title: Logo(),
                pinned: true,
                floating: true,
                elevation: 5,
                expandedHeight: 30,
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 30),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    <Widget>[
                      Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Email:'),
                                FormInput(
                                  hint: 'Doe_john@qrmail.com',
                                  inputType: TextInputType.emailAddress,
                                  validator: (String value) =>
                                      !validator.isEmail(value)
                                          ? 'It\'s not looks like a valid email'
                                          : null,
                                  onSaved: (String value) =>
                                      _userModel.email = value,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Password:'),
                                FormInput(
                                  hint: '******',
                                  obscure: true,
                                  validator: (String value) {
                                    if (value.length < 6)
                                      return 'password at least 6 characters';
                                    _formkey.currentState.save();
                                    return null;
                                  },
                                  onSaved: (String value) {
                                    _userModel.password = value;
                                  },
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Confirm password:'),
                                FormInput(
                                  hint: '******',
                                  obscure: true,
                                  validator: (String value) =>
                                      _userModel.password != value
                                          ? 'password not matched'
                                          : null,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('First Name:'),
                                      FormInput(
                                        hint: 'John',
                                        validator: (String value) =>
                                            value.length < 3
                                                ? 'input at least 3 characters'
                                                : null,
                                        onSaved: (String value) =>
                                            _userModel.firstName = value,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Last Name:'),
                                      FormInput(
                                        hint: 'Doe',
                                        validator: (String value) =>
                                            value.length < 3
                                                ? 'input at least 3 characters'
                                                : null,
                                        onSaved: (String value) =>
                                            _userModel.lastName = value,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Height in cm: '),
                                      FormInput(
                                        hint: '180',
                                        inputType: TextInputType.number,
                                        validator: (String value) =>
                                            !validator.isNumeric(value)
                                                ? 'input number'
                                                : null,
                                        onSaved: (String value) {
                                          try {
                                            _userModel.height =
                                                num.parse(value).toInt();
                                          } catch (e) {
                                            print(e);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Weight in Kg:'),
                                      FormInput(
                                        hint: '75',
                                        inputType: TextInputType.number,
                                        validator: (String value) =>
                                            !validator.isNumeric(value)
                                                ? 'input number'
                                                : null,
                                        onSaved: (String value) {
                                          try {
                                            _userModel.weight =
                                                num.parse(value).toInt();
                                          } catch (e) {
                                            print(e);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      TextColorNavigationButton(
                        title: 'Register Now!',
                        color: Colors.green,
                        onPressed: () async {
                          setState(() {
                            _loading = true;
                          });
                          if (_formkey.currentState.validate()) {
                            _formkey.currentState.save();
                            try {
                              final user =
                                  await _auth.createUserWithEmailAndPassword(
                                email: _userModel.email,
                                password: _userModel.password,
                              );
                              print(user);
                              if (user != null) {
//                                final CollectionReference postsRef =
//                                    _firestore.collection('user');
                                var postID = (await _auth.currentUser()).uid;
                                _firestore
                                    .collection('user')
                                    .document(postID)
                                    .setData({
                                  'email': _userModel.email,
                                  'firstName': _userModel.firstName,
                                  'lastName': _userModel.lastName,
                                  'height': _userModel.height,
                                  'weight': _userModel.weight,
                                  'registrationDate':
                                      FieldValue.serverTimestamp(),
                                });
                                Navigator.pushNamed(context, HomePage.id);
                              }
                            } catch (e) {
                              print(e.code);
                              String message;
                              switch (e.code) {
                                case 'ERROR_NETWORK_REQUEST_FAILED':
                                  message =
                                      'Please check your internet connection';
                                  break;
                                case 'ERROR_INVALID_EMAIL':
                                  message = 'Please input valid email format';
                                  break;
                                case 'ERROR_EMAIL_ALREADY_IN_USE':
                                  message = 'This mail is already used';
                                  break;
                                case 'ERROR_WEAK_PASSWORD':
                                  message =
                                      'Password at least contain 6 characters';
                                  break;
                                case 'error':
                                  message = 'You must fill all fields';
                                  break;
                              }
                              NotificationFlushBar(
                                title: 'Oops!',
                                message: message,
                                error: true,
                              ).build(context);
                            }
                          } else {
                            NotificationFlushBar(
                              title: 'Oops!',
                              message: 'please fill the form',
                              error: true,
                            ).build(context);
                          }

                          setState(() {
                            _loading = false;
                          });
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
