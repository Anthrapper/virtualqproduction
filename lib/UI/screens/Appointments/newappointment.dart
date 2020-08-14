import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtualQ/UI/Animation/fadeanimation.dart';
import 'package:virtualQ/UI/widgets/app_bar.dart';

import 'package:virtualQ/UI/widgets/reusable_widgets.dart';

class NewAppointment extends StatefulWidget {
  @override
  _NewAppointmentState createState() => _NewAppointmentState();
}

class _NewAppointmentState extends State<NewAppointment> {
  String _value = '';

  Future _selectDate() async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(2020, 8, 1),
      lastDate: new DateTime(2020, 12, 31),
    );
    if (picked != null)
      setState(() {
        _value = picked.toString();

        _value = _value.substring(0, _value.indexOf(' 0'));
        print(_value);
      });
  }

  final TextEditingController idController = new TextEditingController();
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
      appBar: CustomAppBar('Create New Appointment'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                FadeAnimation(
                  0.5,
                  ReusableWidgets()
                      .customImage(context, 'assets/images/booking.png'),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Column(
                    children: <Widget>[
                      FadeAnimation(
                        1,
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(143, 148, 251, .2),
                                blurRadius: 20.0,
                                offset: Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              ReusableWidgets().customTextfield(
                                'Ration Card Number',
                                idController,
                                FaIcon(
                                  FontAwesomeIcons.idCard,
                                ),
                                true,
                              ),
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
                                        elevation: 10,
                                        icon: Icon(Icons.arrow_drop_down),
                                        iconSize: 36,
                                        dropdownColor: Colors.grey[200],
                                        hint: Text(
                                          'Choose Purpose',
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
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Icon(
                                      Icons.date_range,
                                      color: Colors.grey,
                                      size: 31,
                                    ),
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        _selectDate();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 0, 0, 0),
                                        child: Text(
                                          'Choose date',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.grey[400],
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      FadeAnimation(
                        1.2,
                        FlatButton(
                          onPressed: () {
                            print('hi');
                          },
                          child: ReusableWidgets()
                              .customButton(context, 'Generate Token'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
