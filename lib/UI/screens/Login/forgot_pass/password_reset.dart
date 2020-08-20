import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:virtualQ/Services/validator.dart';
import 'package:virtualQ/UI/Animation/fadeanimation.dart';
import 'package:virtualQ/UI/widgets/app_bar.dart';
import 'package:virtualQ/UI/widgets/reusable_widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:virtualQ/utilitis/constants/api_urls.dart';

class PasswordReset extends StatefulWidget {
  @override
  _PasswordResetState createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  final TextEditingController pass = new TextEditingController();
  final TextEditingController confPass = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final storage = new FlutterSecureStorage();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    Future<Null> resetPassword(String pass) async {
      String loginToken = await storage.read(key: 'accesstoken');
      print(loginToken);
      Map data = {
        "password": pass,
      };
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $loginToken',
      };
      var response = await http.post(
        Urls.passwordReset,
        body: jsonEncode(data),
        headers: requestHeaders,
      );

      print(response.statusCode);
      if (response.statusCode == 204) {
        Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
      }

      setState(() {
        _isLoading = false;
      });
    }

    return Scaffold(
      appBar: CustomAppBar('Password Reset'),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, 50, 20, 40),
              child: ReusableWidgets()
                  .customImage(context, 'assets/images/reset.png'),
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                child: ReusableWidgets().customContainer(
                  Column(
                    children: [
                      ReusableWidgets().customTextfield(
                        'Enter Password',
                        pass,
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
                          controller: confPass,
                          obscureText: true,
                          validator: (val) => MatchValidator(
                                  errorText: 'passwords do not match')
                              .validateMatch(val, pass.text),
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
            FadeAnimation(
              1.2,
              Padding(
                padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
                child: _isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : InkWell(
                        child: ReusableWidgets()
                            .customButton(context, 'Reset Password'),
                        onTap: () {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              _isLoading = true;
                            });

                            resetPassword(
                              pass.text,
                            );
                          }
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
