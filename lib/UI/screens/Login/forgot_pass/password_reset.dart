import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:virtualQ/Services/Controllers/Login_Controllers/reset_controller.dart';
import 'package:virtualQ/Services/validator.dart';
import 'package:virtualQ/UI/Animation/fadeanimation.dart';
import 'package:virtualQ/UI/widgets/app_bar.dart';
import 'package:virtualQ/UI/widgets/reusable_widgets.dart';

class PasswordReset extends StatelessWidget {
  final PasswordResetController _passwordResetController =
      Get.put(PasswordResetController());
  final ReusableWidgets _reusableWidgets = ReusableWidgets();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar('Password Reset'),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 40),
              child: _reusableWidgets.customImage('assets/images/reset.png'),
            ),
            Form(
              // autovalidate: true,
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                child: _reusableWidgets.customContainer(
                  Column(
                    children: [
                      _reusableWidgets.customTextfield(
                        'Enter Password',
                        _passwordResetController.pass,
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
                          controller: _passwordResetController.confPass,
                          obscureText: true,
                          validator: (val) => MatchValidator(
                                  errorText: 'passwords do not match')
                              .validateMatch(
                                  val, _passwordResetController.pass.text),
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
            FadeAnimation(
              1.2,
              Padding(
                padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
                child: InkWell(
                  child: _reusableWidgets.customButton('Reset Password'),
                  onTap: () {
                    if (_formKey.currentState.validate()) {
                      _reusableWidgets.progressIndicator();
                      _passwordResetController.resetPassword(
                        _passwordResetController.pass.text,
                      );
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
