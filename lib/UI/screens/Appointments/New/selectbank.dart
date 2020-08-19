import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:virtualQ/Services/authentication_helper.dart';
import 'package:virtualQ/UI/Animation/fadeanimation.dart';
import 'package:virtualQ/UI/widgets/reusable_widgets.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:virtualQ/utilitis/constants/api_urls.dart';

class SelectBank extends StatefulWidget {
  @override
  _SelectBankState createState() => _SelectBankState();
}

class _SelectBankState extends State<SelectBank> {
  final storage = new FlutterSecureStorage();
  bool _bankSelected = false;
  Future banks;

  List bankData = List();
  List branchData = List();

  String selBank;
  String selBranch;

  Future getBanks() async {
    AuthenticationHelper().checkTokenStatus();
    String loginToken = await storage.read(key: 'accesstoken');

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $loginToken',
    };
    var res = await http.get(Urls.banks, headers: requestHeaders);
    if (res.statusCode == 200) {
      var resBody = json.decode(res.body);
      print(resBody);

      setState(() {
        bankData = resBody;
      });
    } else {
      throw Exception('Failed to load Banks');
    }
  }

  Future getBranch(String id) async {
    AuthenticationHelper().checkTokenStatus();
    String loginToken = await storage.read(key: 'accesstoken');

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $loginToken',
    };

    var res = await http.get(Urls.banks + '/' + id + Urls.branches,
        headers: requestHeaders);
    if (res.statusCode == 200) {
      var resBody = json.decode(res.body);
      print(resBody);
      setState(() {
        branchData = resBody;
        _bankSelected = false;
      });
    } else {
      throw Exception('Failed to load Branches');
    }
  }

  @override
  void initState() {
    super.initState();
    banks = getBanks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: banks,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        'Select Your Bank',
                        style: TextStyle(
                          color: Colors.lightBlue[900],
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 50, 20, 40),
                      child: ReusableWidgets()
                          .customImage(context, 'assets/images/bank.png'),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                      child: ReusableWidgets().customContainer(
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(25, 0, 25, 5),
                              child: DropdownButton(
                                isExpanded: true,
                                autofocus: true,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 36,
                                dropdownColor: Colors.grey[200],
                                hint: Text(
                                  'Choose Bank',
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                value: selBank,
                                items: bankData.map((item) {
                                  return DropdownMenuItem(
                                    child: Text(
                                      item['name'],
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    value: item['id'].toString(),
                                  );
                                }).toList(),
                                onChanged: (newVal) {
                                  setState(
                                    () {
                                      selBank = newVal;
                                      _bankSelected = true;
                                    },
                                  );
                                  getBranch(selBank);
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(25, 0, 25, 5),
                              child: _bankSelected
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : DropdownButton(
                                      isExpanded: true,
                                      autofocus: true,
                                      icon: Icon(Icons.arrow_drop_down),
                                      iconSize: 36,
                                      dropdownColor: Colors.grey[200],
                                      hint: Text(
                                        'Choose Branch',
                                        style: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      value: selBranch,
                                      items: branchData.map((item) {
                                        return DropdownMenuItem(
                                          child: Text(
                                            item['name'],
                                            style: TextStyle(
                                              fontSize: 15,
                                            ),
                                          ),
                                          value: item['id'].toString(),
                                        );
                                      }).toList(),
                                      onChanged: (newVal) {
                                        setState(
                                          () {
                                            selBranch = newVal;
                                            print(selBranch);
                                          },
                                        );
                                      },
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    FadeAnimation(
                      1.2,
                      Padding(
                        padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
                        child: InkWell(
                          onTap: () {
                            if (selBank != null && selBranch != null) {
                              Navigator.pushNamed(
                                  context, 'tokenform/$selBranch');
                            }
                          },
                          child: ReusableWidgets().customButton(
                            context,
                            'Next',
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}
