import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:qrcode/constants.dart';
import 'package:qrcode/user_model.dart';
import 'package:qrcode/widgets/notification_flush_bar.dart';
import 'package:qrcode/widgets/text_color_navigation_button.dart';
import 'package:validators/validators.dart' as validator;
import 'package:qrcode/widgets/form_input.dart';

String _uid;
UserModel _userModel = UserModel();

class ProfilePage extends StatefulWidget {
  static const String id = 'profile_page';
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formkey = GlobalKey<FormState>();
  final _firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    bool loading = false;
    return SafeArea(
      child: Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: loading,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                title: Text('Edit Profile'),
                centerTitle: true,
                backgroundColor: Colors.teal,
                floating: true,
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  <Widget>[
                    Form(
                      key: _formkey,
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: InputFormLoader(),
                      ),
                    ),
                    TextColorNavigationButton(
                      title: 'Submit',
                      color: Colors.green,
                      onPressed: () async {
                        setState(() {
                          loading = true;
                        });
                        if (_formkey.currentState.validate()) {
                          _formkey.currentState.save();
                          try {
                            _firestore
                                .collection('user')
                                .document(_uid)
                                .updateData({
                              'firstName': _userModel.firstName,
                              'lastName': _userModel.lastName,
                              'height': _userModel.height,
                              'weight': _userModel.weight
                            });
                            Navigator.pop(context);
                          } catch (e) {
                            print(e);
                          }
                        } else {
                          NotificationFlushBar(
                            title: 'Oops!',
                            message: 'please fill the form',
                            error: true,
                          ).build(context);
                        }

                        setState(() {
                          loading = false;
                        });
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class InputFormLoader extends StatelessWidget {
//  final UserModel _userModel;

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final Firestore _firestore = Firestore.instance;

    Future<UserModel> getUserModel() async {
      _uid = (await _auth.currentUser()).uid;
      DocumentSnapshot ds =
          await _firestore.collection('user').document(_uid).get();
      _userModel.email = ds.data['email'];
      _userModel.password = ds.data['password'];
      _userModel.firstName = ds.data['firstName'];
      _userModel.lastName = ds.data['lastName'];
      _userModel.height = ds.data['height'];
      _userModel.weight = ds.data['weight'];
      return _userModel;
    }

    return FutureBuilder(
        future: getUserModel(),
        builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          return Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'First Name: ',
                    style: kTextFieldTitle,
                  ),
                  FormInput(
                    hint: _userModel.firstName,
                    validator: (String value) =>
                        value.length < 3 ? 'input at least 3 characters' : null,
                    onSaved: (String value) => _userModel.firstName = value,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Last Name: ',
                    style: kTextFieldTitle,
                  ),
                  FormInput(
                    inputType: TextInputType.text,
                    hint: _userModel.lastName,
                    validator: (String value) =>
                        value.length < 3 ? 'input at least 3 characters' : null,
                    onSaved: (String value) => _userModel.lastName = value,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Weight: ',
                    style: kTextFieldTitle,
                  ),
                  FormInput(
                    inputType: TextInputType.numberWithOptions(
                        signed: false, decimal: false),
                    hint: _userModel.weight.toString(),
                    validator: (String value) => !validator.isNumeric(value)
                        ? 'input must be number'
                        : null,
                    onSaved: (String value) =>
                        _userModel.weight = num.parse(value).toInt(),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'height: ',
                    style: kTextFieldTitle,
                  ),
                  FormInput(
                    inputType: TextInputType.numberWithOptions(
                        signed: false, decimal: false),
                    hint: _userModel.height.toString(),
                    validator: (String value) => !validator.isNumeric(value)
                        ? 'input must be number'
                        : null,
                    onSaved: (String value) =>
                        _userModel.height = num.parse(value).toInt(),
                  ),
                ],
              ),
            ],
          );
        });
  }
}
