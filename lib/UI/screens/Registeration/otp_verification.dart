import 'package:flutter/material.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';
import 'package:virtualQ/UI/Animation/fadeanimation.dart';
import 'package:virtualQ/UI/screens/home/home.dart';
import 'package:virtualQ/UI/widgets/app_bar.dart';
import 'package:virtualQ/UI/widgets/reusable_widgets.dart';

class OtpVerification extends StatefulWidget {
  @override
  _OtpVerificationState createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
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
                  Container(
                    margin: EdgeInsets.all(8),
                    child: PinEntryTextField(
                      fields: 6,
                      showFieldAsBox: false,
                      onSubmit: (String pin) {
                        print(pin);
                      },
                    ),
                  ),
                ),
              ),
              FadeAnimation(
                1.2,
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    },
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        );
                      },
                      child: ReusableWidgets().customButton(
                        context,
                        'Verify',
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
