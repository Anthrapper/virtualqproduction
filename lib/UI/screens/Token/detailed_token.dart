import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:virtualQ/Services/authentication_helper.dart';
import 'package:virtualQ/UI/widgets/app_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:virtualQ/UI/widgets/reusable_widgets.dart';
import 'package:virtualQ/utilitis/constants/api_urls.dart';

class DetailedToken extends StatefulWidget {
  @override
  _DetailedTokenState createState() => _DetailedTokenState();
}

class _DetailedTokenState extends State<DetailedToken> {
  Future tokenList;
  String userName = '';
  int id;
  String bank = '';
  String branch = '';
  String date = '';
  String service = '';
  String counter = '';
  String token = '';
  final storage = new FlutterSecureStorage();
  tokenStatus(String status) async {
    await AuthenticationHelper().checkTokenStatus();
    String loginToken = await storage.read(key: 'accesstoken');

    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer $loginToken',
    };
    var data = {"id": id.toString(), "status": status};
    var res =
        await http.post(Urls.tokenUpdate, headers: requestHeaders, body: data);
    print(res.body);
    print(res.statusCode);
  }

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
      print(resBody[0]);

      setState(() {
        userName = resBody[0]['username'];
        bank = resBody[0]['bank'];
        id = resBody[0]['id'];
        print(id);
        branch = resBody[0]['branch'];
        date = resBody[0]['token_date'];
        date = date.substring(0, date.indexOf('T'));
        service = resBody[0]['service'];
        token = resBody[0]['order_number'];
        counter = resBody[0]['counter_number'];
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
      appBar: CustomAppBar('Token Details'),
      body: FutureBuilder(
        future: tokenList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 30, 25, 20),
                child: ReusableWidgets().customContainer(
                  Column(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(15),
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Token Number:                   $token',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.lightBlue[900],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ReusableWidgets().customText('Name:   $userName'),
                      ReusableWidgets().customText('Bank:     $bank'),
                      ReusableWidgets().customText('Branch:  $branch'),
                      ReusableWidgets().customText('Date:       $date'),
                      ReusableWidgets().customText('Counter Nmber:  $counter'),
                      ReusableWidgets().customText('Purpose:  $service'),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 8, 20, 5),
                        child: RaisedButton(
                          color: Colors.blueGrey[100],
                          onPressed: () {
                            tokenStatus('10');
                          },
                          child: Center(
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(80, 10, 0, 5),
                                  child: Text(
                                    'Cancel Token',
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.red[800],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Icon(
                                      Icons.cancel,
                                      color: Colors.red[800],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 8, 20, 5),
                        child: RaisedButton(
                          color: Colors.blueGrey[100],
                          onPressed: () {
                            tokenStatus('15');
                          },
                          child: Center(
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(80, 10, 0, 5),
                                  child: Text(
                                    'Completed',
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.red[800],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(14, 10, 0, 0),
                                    child: Icon(
                                      Icons.assignment_turned_in,
                                      color: Colors.red[800],
                                    ),
                                  ),
                                ),
                              ],
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
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
