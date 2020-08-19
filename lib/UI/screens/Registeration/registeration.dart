import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:virtualQ/Services/validator.dart';
import 'package:virtualQ/UI/Animation/fadeanimation.dart';
import 'package:virtualQ/UI/widgets/reusable_widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:virtualQ/utilitis/constants/api_urls.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController phoneController = new TextEditingController();
  final TextEditingController passController = new TextEditingController();
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController confController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Future<Null> signUp(String phone, String name, String password) async {
    Map data = {
      "contact": phone,
      "name": name,
      "password": password,
    };

    var response = await http.post(
      Urls.signUp,
      body: jsonEncode(data),
      headers: {"Content-Type": "application/json"},
    );
    var jsonData = json.decode(response.body);
    print(jsonData);
    if (response.statusCode == 201) {
      setState(
        () {
          _isLoading = false;
        },
      );
      Navigator.pushNamed(context, 'otpverification/$phone');
    } else if (response.statusCode == 400) {
      setState(
        () {
          _isLoading = false;
        },
      );

      if (jsonData['non_field_errors'][0] == 'contact already taken') {
        ReusableWidgets().customDialog(
          context,
          'Registration Failed',
          'An account already exists with the same number, please login',
          AlertType.error,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.lightBlue[900],
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ReusableWidgets()
                    .customImage(context, 'assets/images/signup.png'),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.all(18.0),
                    child: ReusableWidgets().customContainer(
                      Column(
                        children: <Widget>[
                          ReusableWidgets().customTextfield(
                            'Enter Your Name',
                            nameController,
                            FaIcon(Icons.supervised_user_circle),
                            false,
                            FormValidator().reqValidator,
                          ),
                          ReusableWidgets().customTextfield(
                            'Contact',
                            phoneController,
                            FaIcon(Icons.phone),
                            false,
                            FormValidator().mobileValidator,
                          ),
                          ReusableWidgets().customTextfield(
                            'Password',
                            passController,
                            FaIcon(Icons.security),
                            true,
                            FormValidator().passwordValidator,
                          ),
                          Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey[100],
                                ),
                              ),
                            ),
                            child: TextFormField(
                              textAlign: TextAlign.justify,
                              controller: confController,
                              obscureText: true,
                              validator: (val) => MatchValidator(
                                      errorText: 'passwords do not match')
                                  .validateMatch(val, passController.text),
                              decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(top: 12),
                                  child: Icon(Icons.security),
                                ),
                                border: InputBorder.none,
                                hintText: 'Confirm Password',
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: FadeAnimation(
                    1.2,
                    InkWell(
                      onTap: () {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            _isLoading = true;
                          });

                          signUp(phoneController.text, nameController.text,
                              passController.text);
                        }
                      },
                      child: _isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : ReusableWidgets().customButton(context, 'Register'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
