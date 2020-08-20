import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:virtualQ/UI/Animation/fadeanimation.dart';
import 'package:virtualQ/UI/widgets/app_bar.dart';
import 'package:virtualQ/UI/widgets/reusable_widgets.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:virtualQ/utilitis/constants/api_urls.dart';

class MobileVerification extends StatefulWidget {
  final String phone;

  MobileVerification(this.phone);
  @override
  _MobileVerificationState createState() => _MobileVerificationState();
}

class _MobileVerificationState extends State<MobileVerification> {
  final storage = new FlutterSecureStorage();

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    Future<Null> getOtp() async {
      Map data = {
        "contact": widget.phone,
      };

      var response = await http.post(
        Urls.forgotPassOtp,
        body: jsonEncode(data),
        headers: {"Content-Type": "application/json"},
      );
      var jsonData = json.decode(response.body);
      print(jsonData);
      print(response.statusCode);
      if (response.statusCode == 200) {
        setState(() {
          _isLoading = false;
        });
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

    Future<Null> verifyOtp(String otp) async {
      Map data = {
        "token": otp,
        "contact": widget.phone,
      };

      var response = await http.post(
        Urls.passwordTokenGen,
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
        if (jsonData['status'] == 'failed') {
          ReusableWidgets().customDialog(
            context,
            'Wrong Otp',
            'Wrong otp provided, please try again',
            AlertType.error,
          );
        }
      }
      if (response.statusCode == 200) {
        if (jsonData['status'] == 'verified') {
          await storage.write(key: 'accesstoken', value: jsonData['access']);
          await storage.write(key: 'refreshtoken', value: jsonData['refresh']);

          Navigator.pushNamed(context, 'passwordreset');
        }
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
      appBar: CustomAppBar('Mobile Verification'),
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
                child: _isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ReusableWidgets().customContainer(
                        Container(
                          margin: EdgeInsets.all(8),
                          child: PinEntryTextField(
                            fields: 4,
                            showFieldAsBox: false,
                            onSubmit: (String pin) {
                              setState(() {
                                _isLoading = true;
                              });
                              verifyOtp(pin);
                            },
                          ),
                        ),
                      ),
              ),
              FadeAnimation(
                1.7,
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: InkWell(
                    onTap: () {
                      getOtp();
                    },
                    child: Text(
                      "Resend Otp",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.lightBlue[900],
                        fontWeight: FontWeight.bold,
                      ),
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
