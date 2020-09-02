import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:virtualQ/Services/authentication_helper.dart';
import 'package:virtualQ/UI/widgets/reusable_widgets.dart';
import 'package:virtualQ/utilitis/constants/api_urls.dart';

class TokenCreationController extends GetxController {
  TextEditingController idController;
  var data = [].obs;
  var date = ''.obs;
  var value = ''.obs;
  var hintText = ''.obs;
  var hideTextField = true.obs;
  var selectedDate = false.obs;

  @override
  void onInit() {
    idController = TextEditingController();
    getServiceList();
    super.onInit();
  }

  @override
  void onReady() {
    _reusableWidgets.progressIndicator();
    super.onInit();
  }

  Future selectDate() async {
    DateTime picked = await showDatePicker(
      context: Get.context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime.now(),
      lastDate: new DateTime(2020, 12, 31),
    );
    if (picked != null) {
      value.value = DateFormat('dd-MM-yyyy').format(picked);
      selectedDate.value = true;
    }
  }

  final ReusableWidgets _reusableWidgets = ReusableWidgets();
  Future getServiceList() async {
    var loginToken = await AuthenticationHelper().checkTokenStatus();
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $loginToken',
    };
    var url =
        Urls.banks + Urls.branches + Get.parameters['branch'] + Urls.services;
    print(url);
    var res = await http.get(
      url,
      headers: requestHeaders,
    );
    if (res.statusCode == 200) {
      var resBody = json.decode(res.body);
      print(resBody);

      data.value = resBody;
      if (Get.isDialogOpen) {
        Get.back();
      }
    } else {
      throw Exception("Failed to get Services");
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

  Future generateToken({String date, String id, String doc}) async {
    var loginToken = await AuthenticationHelper().checkTokenStatus();

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $loginToken',
    };
    Map data = {
      "token_date": date,
      "service": id,
      "doc_ids": "{ 'id': $doc}",
    };

    var response = await http.post(
      Urls.tokenGen,
      body: jsonEncode(data),
      headers: requestHeaders,
    );
    var jsonData = json.decode(response.body);
    print(jsonData);
    print(response.statusCode);
    if (response.statusCode == 201) {
      _reusableWidgets.okButtonDialog('Success', 'Token Generated Successfully',
          gotoHome, Icons.assignment_turned_in);
    } else if (response.statusCode == 400) {
      _reusableWidgets.okButtonDialog(
          'Failed', jsonData['message'][0], pop, Icons.error);
    } else {
      throw Exception('failed to generate token');
    }
  }

  pop() {
    Get.back();
  }

  gotoHome() {
    Get.offAllNamed('/home');
  }
}
