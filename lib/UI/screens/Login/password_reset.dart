import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtualQ/UI/Animation/fadeanimation.dart';
import 'package:virtualQ/UI/screens/Login/login.dart';
import 'package:virtualQ/UI/widgets/app_bar.dart';
import 'package:virtualQ/UI/widgets/reusable_widgets.dart';

class PasswordReset extends StatefulWidget {
  @override
  _PasswordResetState createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  final TextEditingController pass = new TextEditingController();
  final TextEditingController confPass = new TextEditingController();

  @override
  Widget build(BuildContext context) {
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
            Padding(
              padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
              child: ReusableWidgets().customContainer(
                Column(
                  children: [
                    ReusableWidgets().customTextfield(
                      'Enter Password',
                      pass,
                      FaIcon(Icons.security),
                      true,
                    ),
                    ReusableWidgets().customTextfield(
                      'Confirm Password',
                      pass,
                      FaIcon(Icons.security),
                      true,
                    ),
                  ],
                ),
              ),
            ),
            FadeAnimation(
              1.2,
              Padding(
                padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
                child: InkWell(
                  child:
                      ReusableWidgets().customButton(context, 'Reset Password'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
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
