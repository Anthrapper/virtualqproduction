import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtualQ/UI/Animation/fadeanimation.dart';
import 'package:virtualQ/UI/widgets/reusable_widgets.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController phoneController = new TextEditingController();
  final TextEditingController passController = new TextEditingController();
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController confController = new TextEditingController();

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
                Padding(
                  padding: EdgeInsets.all(18.0),
                  child: ReusableWidgets().customContainer(
                    Column(
                      children: <Widget>[
                        ReusableWidgets().customTextfield(
                          'Enter Your Name',
                          nameController,
                          FaIcon(Icons.supervised_user_circle),
                          false,
                        ),
                        ReusableWidgets().customTextfield(
                          'Contact',
                          phoneController,
                          FaIcon(Icons.phone),
                          false,
                        ),
                        ReusableWidgets().customTextfield(
                          'Password',
                          passController,
                          FaIcon(Icons.security),
                          true,
                        ),
                        ReusableWidgets().customTextfield(
                          'Confirm password',
                          confController,
                          FaIcon(Icons.security),
                          true,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: FadeAnimation(
                    1.2,
                    FlatButton(
                      onPressed: () {
                        print('hi');
                        Navigator.pushNamed(context, 'otpverification');
                      },
                      child:
                          ReusableWidgets().customButton(context, 'Register'),
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
