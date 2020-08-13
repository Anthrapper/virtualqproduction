import 'package:flutter/material.dart';
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
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                FadeAnimation(
                  0.5,
                  Container(
                    padding: EdgeInsets.only(top: 30),
                    height: 270,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/signup.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      FadeAnimation(
                        1,
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(143, 148, 251, .2),
                                  blurRadius: 20.0,
                                  offset: Offset(0, 10),
                                ),
                              ]),
                          child: Column(
                            children: <Widget>[
                              ReusableWidgets().customTextfield(
                                  'Enter Your Name',
                                  nameController,
                                  Icon(Icons.supervised_user_circle),
                                  false),
                              ReusableWidgets().customTextfield(
                                'Contact',
                                phoneController,
                                Icon(Icons.phone),
                                false,
                              ),
                              ReusableWidgets().customTextfield(
                                'Password',
                                passController,
                                Icon(Icons.security),
                                true,
                              ),
                              ReusableWidgets().customTextfield(
                                'Confirm password',
                                confController,
                                Icon(Icons.security),
                                true,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      FadeAnimation(
                        1.2,
                        FlatButton(
                          onPressed: () {
                            print('hi');
                          },
                          child: ReusableWidgets().customButton('Register'),
                        ),
                      ),
                    ],
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
