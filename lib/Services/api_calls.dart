import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiCalls {
  Future postRequest({
    var body,
    var url,
    var headers,
  }) async {
    var response = await http.post(
      url,
      body: jsonEncode(body),
      headers: headers,
    );

    var jsonData = json.decode(response.body);
    print(jsonData);
    print(response.statusCode);
    if (Get.isDialogOpen) {
      Get.back();
    }
    return [response.statusCode, jsonData];
  }

  Future getRequest({var url, var header}) async {
    var response = await http.get(
      url,
      headers: header,
    );

    var jsonData = json.decode(response.body);
    print(jsonData);
    print(response.statusCode);
    if (Get.isDialogOpen) {
      Get.back();
    }
    return [response.statusCode, jsonData];
  }
}
