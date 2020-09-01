class Urls {
  static String baseUrl = 'https://dev.virtualqueue.gq/api/';
  static String loginApi = baseUrl + 'token/';
  static String forgotPassOtp = baseUrl + 'user/reset/';
  static String passwordTokenGen = baseUrl + 'user/password/token/';
  static String passReset = baseUrl + 'user/password/change/';
  static String signUp = baseUrl + 'user/create/';
  static String signUpVerify = baseUrl + 'user/verify/';
  static String refreshToken = baseUrl + 'token/refresh/';
  static String banks = baseUrl + 'banks';
  static String branches = '/branches/';
  static String services = '/services/';
  static String tokenGen = baseUrl + 'customer/token/gen/';
  static String tokenList = baseUrl + 'customer/token/list/';
  static String tokenUpdate = baseUrl + "customer/token/status/update/";
}
