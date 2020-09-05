import 'package:virtualQ/Services/authentication_helper.dart';

class ApiConstants {
  final AuthenticationHelper _authenticationHelper = AuthenticationHelper();
  var jsonHeader = {"Content-Type": "application/json"};

  Future getHeader() async {
    var loginToken = await _authenticationHelper.readAccessToken();
    var headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $loginToken',
    };
    return headers;
  }
}
