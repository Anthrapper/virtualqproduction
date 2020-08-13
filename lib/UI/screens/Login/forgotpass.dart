import 'package:flutter/material.dart';
import 'package:virtualQ/UI/Animation/fadeanimation.dart';
import 'package:virtualQ/UI/widgets/reusable_widgets.dart';

class ForgotPass extends StatefulWidget {
  @override
  _ForgotPassState createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  final TextEditingController phoneController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 20),
              child: Text(
                'Forgot Password',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 50, 30, 30),
              child: FadeAnimation(
                0.5,
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/forgot.png'),
                    ),
                  ),
                ),
              ),
            ),
            FadeAnimation(
              1,
              ReusableWidgets().customTextfield('Enter Your Phone Number',
                  phoneController, Icon(Icons.phone), false),
            ),
            FadeAnimation(
              1.2,
              Padding(
                padding: EdgeInsets.fromLTRB(30, 50, 30, 0),
                child: ReusableWidgets().customButton('Get OTP'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
