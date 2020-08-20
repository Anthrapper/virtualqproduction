import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:virtualQ/Services/authentication_helper.dart';
import 'package:virtualQ/UI/Animation/fadeanimation.dart';
import 'package:virtualQ/UI/widgets/app_bar.dart';
import 'package:virtualQ/UI/widgets/reusable_widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:virtualQ/utilitis/constants/api_urls.dart';

class CurrentAppointments extends StatefulWidget {
  @override
  _CurrentAppointmentsState createState() => _CurrentAppointmentsState();
}

class _CurrentAppointmentsState extends State<CurrentAppointments> {
  Future tokenList;
  List tokenData = List();
  final storage = new FlutterSecureStorage();
  Future getToken() async {
    await AuthenticationHelper().checkTokenStatus();
    String loginToken = await storage.read(key: 'accesstoken');

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $loginToken',
    };
    var res = await http.get(Urls.tokenList, headers: requestHeaders);
    if (res.statusCode == 200) {
      var resBody = json.decode(res.body);
      print(resBody);

      setState(() {
        tokenData = resBody;
      });
    } else {
      throw Exception('Failed to load Banks');
    }
  }

  @override
  void initState() {
    super.initState();
    tokenList = getToken();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar('Current Appointments'),
      body: SafeArea(
        child: FutureBuilder(
          future: tokenList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: tokenData == null ? 0 : tokenData.length,
                itemBuilder: (context, index) {
                  String tokenNumber = tokenData[index]["order_number"];
                  String branch = tokenData[index]["branch"];
                  String date = tokenData[index]["token_date"];
                  String service = tokenData[index]["service"];
                  date = date.substring(0, date.indexOf('T'));
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: FadeAnimation(
                          0.7,
                          ReusableWidgets().customContainer(
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, 'detailedtoken');
                              },
                              child: ReusableWidgets().customContainer(
                                Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(7),
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
                                    ReusableWidgets().customText(
                                        'Token Number:    $tokenNumber'),
                                    ReusableWidgets()
                                        .customText('Branch:    $branch'),
                                    ReusableWidgets()
                                        .customText('Service:    $service'),
                                    ReusableWidgets()
                                        .customText('Date :        $date'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                },
                padding: EdgeInsets.all(30),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
