import 'package:flutter/material.dart';
import 'package:virtualQ/UI/widgets/reusable_widgets.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 60),
            child: Center(
              child: Text(
                'Welcome To VirtualQ',
                style: TextStyle(
                  color: Colors.lightBlue[900],
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                'Stay Apart. Stay Safe',
                style: TextStyle(
                  color: Colors.lightBlue[800],
                  fontSize: 14,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child:
                ReusableWidgets().customImage(context, 'assets/images/q.png'),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30, 80, 30, 0),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, 'login');
              },
              child: ReusableWidgets().customButton(context, 'Login'),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, 'register');
              },
              child: ReusableWidgets().customButton(context, 'Register'),
            ),
          ),
        ],
      ),
    );
  }
}
