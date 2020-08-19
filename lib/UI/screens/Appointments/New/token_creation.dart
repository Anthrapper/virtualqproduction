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
  String _value = '';
  String hintText = '';
  bool _hideTextField = false;
  bool _selectedDate = false;
  widgetCheck(int id) {
    for (var one in data) {
      if (one['id'] == id) {
        print('entered loop');
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
      firstDate: new DateTime(2020, 8, 18),
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
  Future<Null> getServiceList() async {
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
    var resBody = json.decode(res.body);
    //print(resBody);

    setState(() {
      data = resBody;
    });
  }

  @override
  void initState() {
    getServiceList();
    setState(() {
      _hideTextField = true;
    });

    super.initState();
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
        child: SingleChildScrollView(
          child: Container(
            child: Column(
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
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 0, 0),
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
                SizedBox(
                  height: 20,
                ),
                FadeAnimation(
                  1.2,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
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
            ),
          ),
        ),
      ),
    );
  }
}
