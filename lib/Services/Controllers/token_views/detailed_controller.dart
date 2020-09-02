import 'package:get/get.dart';
import 'package:virtualQ/Services/authentication_helper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:virtualQ/utilitis/constants/api_urls.dart';

class DetailedController extends GetxController {
  var id = ''.obs;
  var userName = ''.obs;
  var bank = ''.obs;
  var branch = ''.obs;
  var date = ''.obs;
  var service = ''.obs;
  var counter = ''.obs;
  var token = ''.obs;
  final AuthenticationHelper _authenticationHelper = AuthenticationHelper();
  Future getToken() async {
    var loginToken = await _authenticationHelper.checkTokenStatus();
    print(loginToken);
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $loginToken',
    };
    var res = await http.get(Urls.tokenList, headers: requestHeaders);
    if (res.statusCode == 200) {
      var resBody = json.decode(res.body);
      print(resBody[0]);

      userName.value = resBody[0]['username'].toString();
      bank.value = resBody[0]['bank'].toString();
      id.value = resBody[0]['id'].toString();
      print(id);
      branch.value = resBody[0]['branch'];
      date.value = resBody[0]['token_date'].toString();
      // date.value = date.value.substring(0, date.indexOf('T'));
      service.value = resBody[0]['service'];
      token.value = resBody[0]['order_number'];
      counter.value = resBody[0]['counter_number'];
    } else {
      throw Exception('Failed to load Banks');
    }
  }

  tokenStatus(String status) async {
    var token = await _authenticationHelper.checkTokenStatus();
    print(token);
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer $token',
    };
    var data = {"id": id.value.toString(), "status": status};
    print(Urls.tokenUpdate);

    var res =
        await http.post(Urls.tokenUpdate, headers: requestHeaders, body: data);
    print(res.body);
    print(res.statusCode);
    if (res.statusCode == 200) {
      print('success');
      Get.offAllNamed('/home');
    } else {
      throw Exception("something went wrong");
    }
  }
}
