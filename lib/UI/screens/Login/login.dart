import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtualQ/UI/Animation/fadeanimation.dart';
import 'package:virtualQ/UI/screens/Login/forgotpass.dart';
import 'package:virtualQ/UI/screens/home/home.dart';
import 'package:virtualQ/UI/widgets/reusable_widgets.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController phoneController = new TextEditingController();
  final TextEditingController passController = new TextEditingController();
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
                ReusableWidgets()
                    .customImage(context, 'assets/images/signin.png'),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: ReusableWidgets().customContainer(
                    Column(
                      children: <Widget>[
                        ReusableWidgets().customTextfield('Enter Phone Number',
                            phoneController, FaIcon(Icons.phone), false),
                        ReusableWidgets().customTextfield(
                          'Password',
                          passController,
                          FaIcon(Icons.security),
                          true,
                        ),
                      ],
                    ),
                  ),
                ),
                FadeAnimation(
                  1.5,
                  FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    },
                    child: ReusableWidgets().customButton(context, 'Login'),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                FadeAnimation(
                  1.7,
                  FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForgotPass(),
                        ),
                      );
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
