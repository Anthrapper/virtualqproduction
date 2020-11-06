import 'dart:convert';
import 'package:get/get.dart';
import 'package:virtualq/Services/authentication_helper.dart';
import 'package:http/http.dart' as http;
import 'package:virtualq/UI/widgets/reusable_widgets.dart';
import 'package:virtualq/utilitis/constants/api_urls.dart';

class TokenListController extends GetxController {
  var tokenData = List().obs;
  final AuthenticationHelper _authenticationHelper = AuthenticationHelper();
  Future getToken() async {
    String loginToken = await _authenticationHelper.checkTokenStatus();

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $loginToken',
    };
    var res = await http.get(Urls.tokenList, headers: requestHeaders);
    if (res.statusCode == 200) {
      var resBody = json.decode(res.body);

      tokenData.value = resBody;
      if (Get.isDialogOpen) {
        Get.back();
      }
    } else {
      throw Exception('Failed to load Tokens');
    }
  }

  @override
  void onInit() {
    getToken();
    super.onInit();
  }

  @override
  void onReady() {
    ReusableWidgets().progressIndicator();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
