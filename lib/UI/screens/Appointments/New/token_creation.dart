import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtualQ/Services/Controllers/Appointment_Creation/creation_controller.dart';
import 'package:virtualQ/Services/validator.dart';
import 'package:virtualQ/UI/Animation/fadeanimation.dart';
import 'package:virtualQ/UI/widgets/app_bar.dart';
import 'package:virtualQ/UI/widgets/dropdown.dart';
import 'package:virtualQ/UI/widgets/reusable_widgets.dart';

class NewAppointment extends StatefulWidget {
  @override
  _NewAppointmentState createState() => _NewAppointmentState();
}

class _NewAppointmentState extends State<NewAppointment> {
  serviceOnChanged(String val) {
    setState(() {
      sePurpose = val;
    });
    _reusableWidgets.progressIndicator();
    _tokenCreationController.getTimeSlots(sePurpose);
    _tokenCreationController.widgetCheck(int.parse(sePurpose));
  }

  String sePurpose;
  String timeslot;
  final ReusableWidgets _reusableWidgets = ReusableWidgets();

  final TokenCreationController _tokenCreationController =
      Get.put(TokenCreationController());

  final _formKey = GlobalKey<FormState>();
  timeOnchanged(String val) {
    setState(
      () {
        timeslot = val;
        print(timeslot);
      },
    );
  }

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
                        child: Card(
                          elevation: 1,
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
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 0, 0),
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
                              Expanded(
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: Get.width * 0.3),
                                  child: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black,
                                    size: 39,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        elevation: 1,
                        child: Row(
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
                                padding: EdgeInsets.fromLTRB(0, 0, 20, 5),
                                child: Obx(() => CustomDropDown(
                                      hintText: 'Choose Purpose',
                                      drValue: sePurpose,
                                      data: _tokenCreationController.data.value,
                                      dText: 'service_name',
                                      misc: true,
                                      onChanged: serviceOnChanged,
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Card(
                        elevation: 1,
                        child: Row(
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
                                padding: EdgeInsets.fromLTRB(0, 0, 20, 5),
                                child: Obx(() => CustomDropDown(
                                      hintText: 'Choose Time Slot',
                                      drValue: timeslot,
                                      data: _tokenCreationController
                                          .timeSlots.value,
                                      dText: 'from_time',
                                      onChanged: timeOnchanged,
                                      misc: false,
                                    )),
                              ),
                            ),
                          ],
                        ),
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
              InkWell(
                onTap: () {
                  if (_formKey.currentState.validate()) {
                    if (_tokenCreationController.value.value != null &&
                        sePurpose != null) {
                      _reusableWidgets.progressIndicator();
                      _tokenCreationController.generateToken(
                          timeslot: timeslot,
                          date: _tokenCreationController.date.value,
                          id: sePurpose,
                          doc: _tokenCreationController.idController.text);
                    }
                  }
                },
                child: _reusableWidgets.customButton('Generate Token'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
