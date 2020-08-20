import 'package:flutter/material.dart';
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
              child: ReusableWidgets().customContainer(Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    alignment: Alignment.center,
                    child: Text(
                      'Token Deatails',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.lightBlue[900],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ReusableWidgets().customText('Token Number: xyz'),
                  ReusableWidgets().customText('Service: xyz'),
                  ReusableWidgets().customText('Date : xyz'),
                ],
              )),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(25, 20, 25, 10),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, 'home', (route) => false);
                },
                child: ReusableWidgets().customButton(context, 'Return Home'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
