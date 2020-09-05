import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtualQ/Services/Controllers/Appointment_Creation/creation_controller.dart';
import 'package:virtualQ/Services/validator.dart';
import 'package:virtualQ/UI/Animation/fadeanimation.dart';
import 'package:virtualQ/UI/widgets/app_bar.dart';
import 'package:virtualQ/UI/widgets/reusable_widgets.dart';

class NewAppointment extends StatefulWidget {
  @override
  _NewAppointmentState createState() => _NewAppointmentState();
}

class _NewAppointmentState extends State<NewAppointment> {
  String sePurpose;
  String timeslot;
  final ReusableWidgets _reusableWidgets = ReusableWidgets();

  final TokenCreationController _tokenCreationController =
      Get.put(TokenCreationController());

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar('Create New Appointment'),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            _reusableWidgets.customSvg('assets/images/booking.svg'),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
              child: _reusableWidgets.customContainer(
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          _tokenCreationController.selectDate();
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Icon(
                                Icons.date_range,
                                color: Colors.grey,
                                size: 31,
                              ),
                            ),
                            Obx(
                              () => Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: _tokenCreationController
                                        .selectedDate.value
                                    ? Text(
                                        _tokenCreationController.value.value,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    : Text(
                                        'Select Date',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 156),
                              child: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black,
                                size: 39,
                              ),
                            ),
                          ],
                        ),
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
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 5),
                              child: Obx(
                                () => DropdownButton(
                                  iconEnabledColor: Colors.black,
                                  isExpanded: true,
                                  autofocus: true,
                                  elevation: 10,
                                  icon: Icon(Icons.arrow_drop_down),
                                  iconSize: 36,
                                  dropdownColor: Colors.grey[50],
                                  hint: Text(
                                    'Choose Purpose',
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  value: sePurpose,
                                  items: _tokenCreationController.data.value
                                      .map((item) {
                                    return DropdownMenuItem(
                                      child: Text(
                                        item['service_name'],
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      value: item['id'].toString(),
                                    );
                                  }).toList(),
                                  onChanged: (newVal) {
                                    setState(() {
                                      sePurpose = newVal;
                                    });
                                    _reusableWidgets.progressIndicator();
                                    _tokenCreationController
                                        .getTimeSlots(sePurpose);
                                    _tokenCreationController
                                        .widgetCheck(int.parse(sePurpose));
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Icon(
                              Icons.access_time,
                              color: Colors.grey,
                              size: 31,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 5),
                              child: Obx(
                                () => DropdownButton(
                                  iconEnabledColor: Colors.black,
                                  isExpanded: true,
                                  autofocus: true,
                                  elevation: 10,
                                  icon: Icon(Icons.arrow_drop_down),
                                  iconSize: 36,
                                  dropdownColor: Colors.grey[50],
                                  hint: Text(
                                    'Choose Time Slot',
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  value: timeslot,
                                  items: _tokenCreationController
                                      .timeSlots.value
                                      .map((item) {
                                    return DropdownMenuItem(
                                      child: Text(
                                        "${item['from_time'].toString().substring(0, 5)}   to  ${item['to_time'].toString().substring(0, 5)}",
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      value: item['id'].toString(),
                                    );
                                  }).toList(),
                                  onChanged: (newVal) {
                                    setState(
                                      () {
                                        timeslot = newVal;
                                        print(timeslot);
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      _tokenCreationController.hideTextField.value
                          ? Center(
                              child: SizedBox(),
                            )
                          : _reusableWidgets.customTextfield(
                              _tokenCreationController.hintText.value,
                              _tokenCreationController.idController,
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
                padding: EdgeInsets.fromLTRB(25, 30, 25, 20),
                child: InkWell(
                  onTap: () {
                    if (_formKey.currentState.validate()) {
                      if (_tokenCreationController.value.value != null &&
                          sePurpose != null) {
                        _tokenCreationController.generateToken(
                            date: _tokenCreationController.date.value,
                            id: sePurpose,
                            doc: _tokenCreationController.idController.text);
                      }
                    }
                  },
                  child: _reusableWidgets.customButton('Generate Token'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
