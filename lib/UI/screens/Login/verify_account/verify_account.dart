import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:virtualQ/Services/validator.dart';
import 'package:virtualQ/UI/Animation/fadeanimation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:virtualQ/UI/widgets/reusable_widgets.dart';
import 'package:virtualQ/utilitis/constants/api_urls.dart';

class VerifyAccount extends StatefulWidget {
  @override
  _VerifyAccountState createState() => _VerifyAccountState();
}

class _VerifyAccountState extends State<VerifyAccount> {
  final TextEditingController phoneController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    Future<Null> getOtp(String phone) async {
      Map data = {
        "contact": phone,
      };

      var response = await http.post(
        Urls.forgotPassOtp,
        body: jsonEncode(data),
        headers: {"Content-Type": "application/json"},
      );
      var jsonData = json.decode(response.body);
      print(jsonData);
      print(response.statusCode);
      if (response.statusCode == 201) {
        setState(() {
          _isLoading = false;
        });
        Navigator.pushNamed(context, 'otpverification/$phone');
      }
      if (response.statusCode == 404) {
        setState(() {
          _isLoading = false;
        });
        ReusableWidgets().customDialog(
          context,
          'Wrong Number',
          'No account exists with the given number',
          AlertType.error,
        );
      }
    }

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 20),
              child: Text(
                'Verify Account',
                style: TextStyle(
                  color: Colors.lightBlue[900],
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 50, 20, 40),
              child: ReusableWidgets()
                  .customImage(context, 'assets/images/verify.png'),
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                child: ReusableWidgets().customContainer(
                  ReusableWidgets().customTextfield(
                    'Enter Phone Number',
                    phoneController,
                    FaIcon(Icons.phone),
                    false,
                    FormValidator().mobileValidator,
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
                        child:
                            ReusableWidgets().customButton(context, 'Get OTP'),
                        onTap: () {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              _isLoading = true;
                            });
                            getOtp(phoneController.text);
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
