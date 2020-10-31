import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:virtualQ/UI/widgets/reusable_widgets.dart';
import 'package:virtualQ/utilitis/constants/api_constants.dart';
import 'package:virtualQ/utilitis/constants/api_urls.dart';

class AuthenticationHelper {
  final storage = FlutterSecureStorage();
  Future storeToken(String access, String refresh) async {
    await storage.write(key: 'accesstoken', value: access);
    await storage.write(key: 'refreshtoken', value: refresh);
  }

  Future removeToken() async {
    await storage.delete(key: 'accesstoken');
    await storage.delete(key: 'refreshtoken');
    print('successfully cleared the tokens');
  }

  Future<String> readAccessToken() async {
    return await storage.read(key: 'accesstoken');
  }

  checkLoginStatus() async {
    String loginToken = await storage.read(key: 'accesstoken');
    String refreshToken = await storage.read(key: 'refreshtoken');
    if (loginToken != null) {
      print('ACCESS TOKEN EXISTS');
      if (JwtDecoder.isExpired(loginToken) == false) {
        print('ACCESS TOKEN is LIVE');
        Get.offAllNamed('home');
      } else {
        print('ACCESS TOKEN EXPIRED');

        if (JwtDecoder.isExpired(refreshToken) == false) {
          print('refresh token is alive');

          Map data = {
            'refresh': refreshToken,
          };
          try {
            var response = await http.post(
              Urls.refreshToken,
              body: jsonEncode(data),
              headers: ApiConstants().jsonHeader,
            );
            var jsonData = json.decode(response.body);
            print(jsonData);
            if (response.statusCode == 200) {
              print('new access token recieved');
              await storage.write(
                  key: 'accesstoken', value: jsonData['access']);

              Get.offAllNamed('home');
            } else {
              print('error getting token');
              Get.offAllNamed('apphome');
            }
          } on SocketException catch (e) {
            print(e);
            ReusableWidgets().noInternet();
          }
        } else {
          print('refresh token expired you need to login again');
          Get.offAllNamed('apphome');
        }
      }
    } else {
      print('no token found, you need to login again');
      Get.offAllNamed('apphome');
    }
  }

  Future<String> checkTokenStatus() async {
    String loginToken = await storage.read(key: 'accesstoken');
    String refreshToken = await storage.read(key: 'refreshtoken');
    if (JwtDecoder.isExpired(loginToken) == false) {
      print('access token alive');
      return loginToken;
    } else {
      print('access token expired');

      if (JwtDecoder.isExpired(refreshToken) == false) {
        print('refresh token is alive');

        Map data = {
          'refresh': refreshToken,
        };
        try {
          var response = await http.post(
            Urls.refreshToken,
            body: jsonEncode(data),
            headers: {"Content-Type": "application/json"},
          );
          var jsonData = json.decode(response.body);
          print(jsonData);
          if (response.statusCode == 200) {
            print('new access token recieved');
            await storage.write(key: 'accesstoken', value: jsonData['access']);
            return jsonData['access'];
          }
        } on SocketException {
          ReusableWidgets().noInternet();
        }
      } else {
        print('refresh token expired');
        Get.offAllNamed('/apphome');
        return 'nothing';
      }
      return 'nothing';
    }
  }
}
