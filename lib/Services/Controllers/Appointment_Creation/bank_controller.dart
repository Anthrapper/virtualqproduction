import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:virtualQ/Services/authentication_helper.dart';
import 'package:virtualQ/UI/widgets/reusable_widgets.dart';
import 'package:virtualQ/utilitis/constants/api_urls.dart';

class BankController extends GetxController {
  var branchData = [].obs;
  var bankData = [].obs;
  var branch = ''.obs;
  var showBranch = true.obs;

  @override
  void onInit() {
    getBanks();
    super.onInit();
  }

  @override
  void onReady() {
    ReusableWidgets().progressIndicator();
    super.onInit();
  }

  Future getBanks() async {
    var loginToken = await AuthenticationHelper().checkTokenStatus();

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $loginToken',
    };
    try {
      var res = await http.get(Urls.banks, headers: requestHeaders);
      if (res.statusCode == 200) {
        var resbody = json.decode(res.body);

        bankData.value = resbody;
        if (Get.isDialogOpen) {
          Get.back();
        }
        print(bankData);
      }
    } on SocketException {
      ReusableWidgets().noInternet();
    }
  }

  Future getBranch(String id) async {
    String loginToken = await AuthenticationHelper().checkTokenStatus();

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

      branchData.value = resBody;
      if (Get.isDialogOpen) {
        Get.back();
      }
    } else {
      throw Exception('Failed to load Branches');
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
