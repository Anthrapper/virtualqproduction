import 'dart:io';
import 'package:get/get.dart';
import 'package:virtualq/Services/api_calls.dart';
import 'package:virtualq/UI/widgets/reusable_widgets.dart';
import 'package:virtualq/utilitis/constants/api_constants.dart';
import 'package:virtualq/utilitis/constants/api_urls.dart';

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
    super.onReady();
  }

  Future getBanks() async {
    try {
      var getData = await ApiCalls().getRequest(
        url: Urls.banks,
        header: await ApiConstants().getHeader(),
      );

      if (getData[0] == 200) {
        bankData.value = getData[1];

        print(bankData);
      }
    } on SocketException {
      ReusableWidgets().noInternet();
    }
  }

  Future getBranch(String id) async {
    try {
      var getData = await ApiCalls().getRequest(
        url: Urls.banks + '/' + id + Urls.branches,
        header: await ApiConstants().getHeader(),
      );
      if (getData[0] == 200) {
        branchData.value = getData[1];
      }
    } on SocketException {
      ReusableWidgets().noInternet();
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
