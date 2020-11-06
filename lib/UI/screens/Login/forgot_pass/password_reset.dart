import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:virtualq/Services/Controllers/Login_Controllers/reset_controller.dart';
import 'package:virtualq/Services/validator.dart';
import 'package:virtualq/UI/Animation/fadeanimation.dart';
import 'package:virtualq/UI/widgets/app_bar.dart';
import 'package:virtualq/UI/widgets/reusable_widgets.dart';

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
            _reusableWidgets.customImage('assets/images/reset.png'),
            Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: Get.height * 0.05,
                  horizontal: Get.width * 0.07,
                ),
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
              InkWell(
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
          ],
        ),
      ),
    );
  }
}
