import 'package:flutter/material.dart';
import 'package:virtualQ/UI/Animation/fadeanimation.dart';
import 'package:virtualQ/UI/screens/Appointments/New/token_creation.dart';
import 'package:virtualQ/UI/widgets/reusable_widgets.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SelectBank extends StatefulWidget {
  @override
  _SelectBankState createState() => _SelectBankState();
}

class _SelectBankState extends State<SelectBank> {
  List data = List();
  String selBatch;

  List deptData = List();
  Future<String> getBatchApi() async {
    var res = await http.get('batchApi');
    var resBody = json.decode(res.body);
    setState(() {
      data = resBody;
    });
    return "Sucess";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
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
              child: Column(
                children: <Widget>[
                  ReusableWidgets().customContainer(
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Icon(
                            Icons.assistant_photo,
                            color: Colors.grey,
                            size: 31,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 18),
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
                              value: selBatch,
                              items: data.map((item) {
                                return DropdownMenuItem(
                                  child: Text(
                                    item['batch'],
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
                                    selBatch = newVal;
                                    print(selBatch);
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            FadeAnimation(
              1.2,
              Padding(
                padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewAppointment(),
                      ),
                    );
                  },
                  child: ReusableWidgets().customButton(
                    context,
                    'Next',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
