import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:virtualQ/Services/validator.dart';
import 'package:virtualQ/UI/Animation/fadeanimation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:virtualQ/UI/widgets/reusable_widgets.dart';
import 'package:virtualQ/utilitis/constants/api_urls.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController phoneController = new TextEditingController();
  final TextEditingController passController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final storage = new FlutterSecureStorage();

  bool _isLoading = false;

  Future<Null> login(String phone, String pass) async {
    Map data = {
      "username": phone,
      "password": pass,
    };

    var response = await http.post(
      Urls.loginApi,
      body: jsonEncode(data),
      headers: {"Content-Type": "application/json"},
    );
    var jsonData = json.decode(response.body);
    print(jsonData);
    print(response.statusCode);
    if (response.statusCode == 200) {
      await storage.write(key: 'accesstoken', value: jsonData['access']);
      await storage.write(key: 'refreshtoken', value: jsonData['refresh']);
      setState(
        () {
          _isLoading = false;
        },
      );
      Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
    } else if (response.statusCode == 401) {
      setState(
        () {
          _isLoading = false;
        },
      );
      if (jsonData['detail'] ==
          'No active account found with the given credentials') {
        ReusableWidgets().customDialog(
          context,
          'Login Failed',
          'Unable to Login with given credentials',
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
                    'Login',
                    style: TextStyle(
                      color: Colors.lightBlue[900],
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: ReusableWidgets()
                      .customImage(context, 'assets/images/signin.png'),
                ),
                Padding(
                  padding: EdgeInsets.all(18.0),
                  child: ReusableWidgets().customContainer(
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          ReusableWidgets().customTextfield(
                            'Enter Phone Number',
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
                            FormValidator().reqValidator,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                FadeAnimation(
                  1.5,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: _isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : InkWell(
                            onTap: () {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  _isLoading = true;
                                });

                                login(
                                  phoneController.text,
                                  passController.text,
                                );
                              }
                            },
                            child: ReusableWidgets()
                                .customButton(context, 'Login'),
                          ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                FadeAnimation(
                  1.7,
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, 'forgotpass');
                    },
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                      ),
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
