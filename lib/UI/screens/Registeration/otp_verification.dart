import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:virtualQ/UI/Animation/fadeanimation.dart';
import 'package:virtualQ/UI/widgets/app_bar.dart';
import 'package:virtualQ/UI/widgets/reusable_widgets.dart';
import 'package:http/http.dart' as http;
import 'package:virtualQ/utilitis/constants/api_urls.dart';

class OtpVerification extends StatefulWidget {
  final String phone;

  OtpVerification(this.phone);
  @override
  _OtpVerificationState createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  verifiedDialog() {
    Alert(
      context: context,
      type: AlertType.success,
      title: 'Account Verified',
      desc: 'Account has been created and verified successfully, Please login',
      buttons: [
        DialogButton(
          gradient: LinearGradient(
            colors: [
              Colors.lightBlue,
              Colors.lightBlueAccent[200],
            ],
          ),
          child: Text(
            "Ok",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context, 'apphome', (route) => false),
          height: 60,
          width: 100,
        )
      ],
    ).show();
  }

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Future<Null> verifyOtp(String pin) async {
    Map data = {
      "token": pin,
      "contact": widget.phone,
    };

    var response = await http.post(
      Urls.signUpVerify,
      body: jsonEncode(data),
      headers: {"Content-Type": "application/json"},
    );
    var jsonData = json.decode(response.body);
    print(jsonData);
    print(response.statusCode);
    if (response.statusCode == 201) {
      setState(
        () {
          _isLoading = false;
        },
      );
      if (jsonData['status'] == 'verified') {
        verifiedDialog();
      } else if (jsonData['status'] == 'failed') {
        ReusableWidgets().customDialog(
          context,
          'Registration Failed',
          'Wrong OTP provided, please re-enter the otp',
          AlertType.error,
        );
      }
    } else if (response.statusCode == 400) {
      setState(
        () {
          _isLoading = false;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        'Verify Your Mobile',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20, 50, 20, 40),
                child: ReusableWidgets()
                    .customImage(context, 'assets/images/forgotpass.png'),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                child: ReusableWidgets().customContainer(
                  Form(
                    key: _formKey,
                    child: Container(
                      margin: EdgeInsets.all(8),
                      child: _isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : PinEntryTextField(
                              fields: 4,
                              showFieldAsBox: false,
                              onSubmit: (String pin) {
                                print(pin);
                                if (_formKey.currentState.validate()) {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  verifyOtp(pin);
                                }
                              },
                            ),
                    ),
                  ),
                ),
              ),
              FadeAnimation(
                1.2,
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
                  child: InkWell(
                    onTap: () {},
                    child: ReusableWidgets().customButton(
                      context,
                      'Resend Otp',
                    ),
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
