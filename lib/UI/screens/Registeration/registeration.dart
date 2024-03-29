import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:virtualq/Services/Controllers/Registration_Controller/signup_controller.dart';
import 'package:virtualq/Services/validator.dart';
import 'package:virtualq/UI/Animation/fadeanimation.dart';
import 'package:virtualq/UI/widgets/reusable_widgets.dart';

class SignUpForm extends StatelessWidget {
  final ReusableWidgets _reusableWidgets = ReusableWidgets();
  final SignupController _signupController = Get.put(SignupController());

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            heading(),
            _reusableWidgets.customImage('assets/images/signup.png'),
            Form(
              key: _formKey,
              child: _reusableWidgets.customContainer(
                Column(
                  children: <Widget>[
                    _reusableWidgets.customTextfield(
                      'Enter Your Name',
                      _signupController.nameController,
                      FaIcon(Icons.supervised_user_circle),
                      false,
                      FormValidator().reqValidator,
                    ),
                    _reusableWidgets.customTextfield(
                      'Contact',
                      _signupController.phoneController,
                      FaIcon(Icons.phone),
                      false,
                      FormValidator().mobileValidator,
                    ),
                    _reusableWidgets.customTextfield(
                      'Password',
                      _signupController.passController,
                      FaIcon(Icons.security),
                      true,
                      FormValidator().passwordValidator,
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey[100],
                          ),
                        ),
                      ),
                      child: TextFormField(
                        textAlign: TextAlign.justify,
                        controller: _signupController.confController,
                        obscureText: true,
                        validator: (val) =>
                            MatchValidator(errorText: 'passwords do not match')
                                .validateMatch(
                                    val, _signupController.passController.text),
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(top: 12),
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
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: FadeAnimation(
                1.2,
                InkWell(
                    onTap: () {
                      if (_formKey.currentState.validate()) {
                        _reusableWidgets.progressIndicator();
                        _signupController.signUp(
                          _signupController.phoneController.text,
                          _signupController.nameController.text,
                          _signupController.passController.text,
                        );
                      }
                    },
                    child: _reusableWidgets.customButton('Register')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget heading() {
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.only(top: 10),
    child: Text(
      'Sign Up',
      style: TextStyle(
        color: Colors.lightBlue[900],
        fontSize: Get.width * 0.09,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
