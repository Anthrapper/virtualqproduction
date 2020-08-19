import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:virtualQ/UI/widgets/reusable_widgets.dart';
import 'package:http/http.dart' as http;
import 'package:virtualQ/utilitis/constants/api_urls.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final storage = FlutterSecureStorage();
  bool _isLoading = false;

  checkLoginStatus() async {
    String loginToken = await storage.read(key: 'accesstoken');
    String refreshToken = await storage.read(key: 'refreshtoken');
    if (loginToken != null) {
      print('accesstoken exists');
      if (JwtDecoder.isExpired(loginToken) == false) {
        setState(() {
          _isLoading = false;
        });
        print('access token is alive');
        Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
      } else {
        print('access token is expired');

        if (JwtDecoder.isExpired(refreshToken) == false) {
          print('refresh token is alive');

          Map data = {
            'refresh': refreshToken,
          };
          var response = await http.post(
            Urls.refreshToken,
            body: jsonEncode(data),
            headers: {"Content-Type": "application/json"},
          );
          var jsonData = json.decode(response.body);
          print(jsonData);
          if (response.statusCode == 200) {
            print('new access token recieved');
            await storage.write(key: 'accesstoken', value: jsonData['access']);
            setState(() {
              _isLoading = false;
            });
            Navigator.pushNamedAndRemoveUntil(
                context, 'home', (route) => false);
          }
        } else {
          setState(() {
            _isLoading = false;
          });
          print('you need to login again');
          Navigator.pushNamed(context, 'login');
        }
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      print('you need to login again');
      Navigator.pushNamed(context, 'login');
    }
  }

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
            child: _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : InkWell(
                    onTap: () {
                      setState(() {
                        _isLoading = true;
                      });
                      checkLoginStatus();
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
