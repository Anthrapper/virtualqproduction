import 'package:flutter/material.dart';
import 'package:virtualQ/UI/screens/Token/token.dart';
import 'package:virtualQ/UI/widgets/app_bar.dart';
import 'package:virtualQ/UI/widgets/reusable_widgets.dart';

class TokenSuccess extends StatefulWidget {
  @override
  _TokenSuccessState createState() => _TokenSuccessState();
}

class _TokenSuccessState extends State<TokenSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar('Token Generated Successfully'),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, 50, 20, 10),
              child: ReusableWidgets()
                  .customImage(context, 'assets/images/success.png'),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 10, 25, 20),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, 'detailedtoken');
                },
                child: ReusableWidgets().customContainer(
                  Token(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
