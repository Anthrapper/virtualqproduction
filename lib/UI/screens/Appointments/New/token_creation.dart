import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtualQ/Services/authentication_helper.dart';
import 'package:virtualQ/Services/validator.dart';
import 'package:virtualQ/UI/Animation/fadeanimation.dart';
import 'package:virtualQ/UI/widgets/app_bar.dart';
import 'package:virtualQ/UI/widgets/reusable_widgets.dart';
import 'package:virtualQ/utilitis/constants/api_urls.dart';

class NewAppointment extends StatefulWidget {
  final String selBranch;
  NewAppointment(this.selBranch);
  @override
  _NewAppointmentState createState() => _NewAppointmentState();
}

class _NewAppointmentState extends State<NewAppointment> {
  final storage = new FlutterSecureStorage();
  final _formKey = GlobalKey<FormState>();
  Future services;
  String _value = '';
  String hintText = '';
  // String _curTokens = '';
  // String _totalTokens = '';

  bool _hideTextField = true;
  bool _selectedDate = false;
  widgetCheck(int id) {
    for (var one in data) {
      if (one['id'] == id) {
        List services = one['service']['service_requirements'];

        if (services.isNotEmpty) {
          setState(() {
            hintText = (one['service']['service_requirements'][0]['doc_name']);
            _hideTextField = false;
          });
        } else {
          print('no doc req');
          setState(() {
            _hideTextField = true;
          });
        }
      }
    }
  }

  Future _selectDate() async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime.now(),
      lastDate: new DateTime(2020, 12, 31),
    );
    if (picked != null)
      setState(() {
        _value = picked.toString();

        _value = _value.substring(0, _value.indexOf(' 0'));
        print(_value);
        _selectedDate = true;
      });
  }

  final TextEditingController idController = new TextEditingController();
  List data = List();
  String selPurpose;
  List deptData = List();
  Future getServiceList() async {
    AuthenticationHelper().checkTokenStatus();
    String loginToken = await storage.read(key: 'accesstoken');
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $loginToken',
    };
    var url = Urls.banks + Urls.branches + widget.selBranch + Urls.services;
    var res = await http.get(
      url,
      headers: requestHeaders,
    );
    if (res.statusCode == 200) {
      var resBody = json.decode(res.body);
      setState(() {
        data = resBody;
      });
    } else {
      throw Exception("Failed to get Services");
    }
  }

  @override
  void initState() {
    super.initState();
    services = getServiceList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar('Create New Appointment'),
      body: SafeArea(
        child: FutureBuilder(
          future: services,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView(
                children: <Widget>[
                  ReusableWidgets()
                      .customImage(context, 'assets/images/booking.png'),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: ReusableWidgets().customContainer(
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
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
                                    padding: EdgeInsets.fromLTRB(20, 0, 20, 5),
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
                                      value: selPurpose,
                                      items: data.map((item) {
                                        return DropdownMenuItem(
                                          child: Text(
                                            item['service_name'],
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
                                            selPurpose = newVal;
                                            print(selPurpose);
                                            widgetCheck(int.parse(selPurpose));
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
                                      child: _selectedDate
                                          ? Text(
                                              _value,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color: Colors.grey[400],
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          : Text(
                                              'Select Date',
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
                            ),
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Icon(
                                      Icons.bookmark,
                                      color: Colors.grey,
                                      size: 31,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      'Current Bookings:',
                                      style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Text(
                                        '50/ 70',
                                        style: TextStyle(
                                          color: Colors.lightBlue,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            _hideTextField
                                ? Center(
                                    child: SizedBox(),
                                  )
                                : ReusableWidgets().customTextfield(
                                    hintText,
                                    idController,
                                    FaIcon(
                                      FontAwesomeIcons.idCard,
                                    ),
                                    true,
                                    FormValidator().reqValidator,
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  FadeAnimation(
                    1.2,
                    Padding(
                      padding: EdgeInsets.fromLTRB(25, 50, 25, 20),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, 'tokensuccess');
                        },
                        child: ReusableWidgets()
                            .customButton(context, 'Generate Token'),
                      ),
                    ),
                  ),
                ],
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
