import 'dart:convert';
import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:virtualq/Services/api_calls.dart';
import 'package:virtualq/UI/widgets/reusable_widgets.dart';
import 'package:virtualq/utilitis/constants/api_constants.dart';
import 'package:virtualq/utilitis/constants/api_urls.dart';

class TokenCreationController extends GetxController {
  final ReusableWidgets _reusableWidgets = ReusableWidgets();
  FlutterLocalNotificationsPlugin notificationsPlugin;

  TextEditingController idController;
  var data = [].obs;
  var timeSlots = [].obs;
  var date = ''.obs;
  var value = ''.obs;
  var hintText = ''.obs;
  var hideTextField = true.obs;
  var selectedDate = false.obs;

  @override
  void onInit() {
    var initNotification = new AndroidInitializationSettings('icon');
    var initSettings = new InitializationSettings(android: initNotification);
    notificationsPlugin = new FlutterLocalNotificationsPlugin();
    notificationsPlugin.initialize(initSettings,
        onSelectNotification: selectNotification);
    idController = TextEditingController();
    getServiceList();
    super.onInit();
  }

  showNotification(String description) async {
    var android = new AndroidNotificationDetails(
      'id',
      'name',
      'description',
      importance: Importance.max,
    );
    var generalDetails = new NotificationDetails(android: android);
    await notificationsPlugin.show(0, 'virtualq', description, generalDetails);
  }

  Future selectNotification(String payload) async {}

  @override
  void onReady() {
    _reusableWidgets.progressIndicator();
    super.onReady();
  }

  Future selectDate() async {
    DateTime picked = await showDatePicker(
      context: Get.context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        Duration(days: 600),
      ),
    );
    if (picked != null) {
      value.value = DateFormat('dd-MM-yyyy').format(picked);
      date.value = picked.toString();
      selectedDate.value = true;
    }
  }

  Future getTimeSlots(String id) async {
    try {
      var getData = await ApiCalls().getRequest(
        header: await ApiConstants().getHeader(),
        url: Urls.timeSlotBase + id + Urls.timeSlot,
      );

      if (getData[0] == 200) {
        timeSlots.value = getData[1];
      }
    } on SocketException {
      _reusableWidgets.noInternet();
    }
  }

  Future getServiceList() async {
    try {
      var getData = await ApiCalls().getRequest(
        header: await ApiConstants().getHeader(),
        url: Urls.banks +
            Urls.branches +
            Get.parameters['branch'] +
            Urls.services,
      );

      if (getData[0] == 200) {
        data.value = getData[1];
      }
    } on SocketException {
      _reusableWidgets.noInternet();
    }
  }

  widgetCheck(int id) {
    for (var one in data.value) {
      if (one['id'] == id) {
        List services = one['service']['service_requirements'];

        if (services.isNotEmpty) {
          print('text field required');
          hintText.value =
              (one['service']['service_requirements'][0]['doc_name']);
          print(hintText.value);
          hideTextField.value = false;
        } else {
          print('no doc req');
          hideTextField.value = true;
        }
      }
    }
  }

  Future generateToken(
      {String date, String id, String doc, String timeslot}) async {
    Map data = {
      "token_date": date,
      "service": id,
      "doc_ids": "{ 'id': $doc}",
      "service_time_slot": timeslot,
    };

    var response = await http.post(
      Urls.tokenGen,
      body: jsonEncode(data),
      headers: await ApiConstants().getHeader(),
    );
    var jsonData = json.decode(response.body);
    print(jsonData);
    if (Get.isDialogOpen) {
      Get.back();
    }
    if (response.statusCode == 201) {
      _reusableWidgets
          .snackBar('Success', 'Token Generated Successfully',
              Icons.assignment_turned_in)
          .then((value) => gotoHome());

      showNotification('Success! Token Generated Successfully');
    } else if (response.statusCode == 400) {
      _reusableWidgets.snackBar('Failed', jsonData['message'][0], Icons.error);
    } else {
      throw Exception('failed to generate token');
    }
  }

  gotoHome() {
    Get.offAllNamed('/home');
  }
}
