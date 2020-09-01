import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
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
    String loginToken = await storage.read(key: 'accesstoken');
    return loginToken;
  }

  checkLoginStatus() async {
    String loginToken = await storage.read(key: 'accesstoken');
    String refreshToken = await storage.read(key: 'refreshtoken');
    if (loginToken != null) {
      print('accesstoken exists');
      if (JwtDecoder.isExpired(loginToken) == false) {
        print('access token is alive');
        Get.offAllNamed('home');
      } else {
        print('access token is expired');

        if (JwtDecoder.isExpired(refreshToken) == false) {
          print('refresh token is alive');

          Map data = {
            'refresh': refreshToken,
          };
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

            Get.offAllNamed('home');
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
      print('access token is alive');
      return loginToken;
    } else {
      print('access token is expired');

      if (JwtDecoder.isExpired(refreshToken) == false) {
        print('refresh token is alive');

        Map data = {
          'refresh': refreshToken,
        };
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
      } else {
        print('refresh token expired');
        Get.offAllNamed('/apphome');
        return 'nothing';
      }
      return 'nothing';
    }
  }
}
