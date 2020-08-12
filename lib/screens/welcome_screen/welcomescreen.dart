import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 150),
            child: Center(
              child: Text(
                'Welcome To VirtualQ',
                style: TextStyle(fontSize: 30),
              ),
            ),
          ),
          FlatButton(
            onPressed: () {},
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            textColor: Colors.white,
            color: Colors.blue,
            child: Text(
              'Login',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Roboto',
              ),
            ),
          ),
          FlatButton(
            onPressed: () {},
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            textColor: Colors.white,
            color: Colors.blue,
            child: Text(
              'Register',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Roboto',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
