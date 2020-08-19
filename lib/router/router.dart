import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:virtualQ/UI/screens/Appointments/Current/currentappointments.dart';
import 'package:virtualQ/UI/screens/Appointments/New/selectbank.dart';
import 'package:virtualQ/UI/screens/Appointments/New/token_creation.dart';
import 'package:virtualQ/UI/screens/Login/forgotpass.dart';
import 'package:virtualQ/UI/screens/Login/login.dart';
import 'package:virtualQ/UI/screens/Login/otpverify.dart';
import 'package:virtualQ/UI/screens/Login/password_reset.dart';
import 'package:virtualQ/UI/screens/Registeration/otp_verification.dart';
import 'package:virtualQ/UI/screens/Registeration/registeration.dart';
import 'package:virtualQ/UI/screens/Token/detailed_token.dart';
import 'package:virtualQ/UI/screens/Token/token_generated.dart';
import 'package:virtualQ/UI/screens/home/home.dart';
import 'package:virtualQ/UI/screens/welcome_screen/welcomescreen.dart';

class FluroRouter {
  static Router router = Router();
  static Handler _loginHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
        LoginPage(),
  );
  static Handler _welcomeHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
        WelcomeScreen(),
  );
  static Handler _homeHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
        HomePage(),
  );
  static Handler _regHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
        SignUpForm(),
  );
  static Handler _forgotPassHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
        ForgotPass(),
  );
  static Handler _otpHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
        MobileVerification(params["phone"][0]),
  );
  static Handler _otpVerificationHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
        OtpVerification(params["phone"][0]),
  );
  static Handler _resetHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
        PasswordReset(),
  );
  static Handler _curAppointments = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
        CurrentAppointments(),
  );
  static Handler _bankSelection = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
        SelectBank(),
  );
  static Handler _tokenForm = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
        NewAppointment(params["selBranch"][0]),
  );
  static Handler _tokenSuccess = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
        TokenSuccess(),
  );
  static Handler _tokenDetails = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
        DetailedToken(),
  );
  static void setupRouter() {
    router.define(
      'login',
      handler: _loginHandler,
    );
    router.define(
      'register',
      handler: _regHandler,
    );
    router.define(
      'apphome',
      handler: _welcomeHandler,
    );

    router.define(
      'home',
      handler: _homeHandler,
    );
    router.define(
      'forgotpass',
      handler: _forgotPassHandler,
    );
    router.define(
      'otp/:phone',
      handler: _otpHandler,
    );
    router.define(
      'otpverification/:phone',
      handler: _otpVerificationHandler,
    );
    router.define(
      'passwordreset',
      handler: _resetHandler,
    );

    router.define(
      'currentappointments',
      handler: _curAppointments,
    );
    router.define(
      'bankselection',
      handler: _bankSelection,
    );
    router.define(
      'tokenform/:selBranch',
      handler: _tokenForm,
    );
    router.define(
      'tokensuccess',
      handler: _tokenSuccess,
    );
    router.define(
      'detailedtoken',
      handler: _tokenDetails,
    );
  }
}
