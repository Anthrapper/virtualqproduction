import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:virtualQ/UI/screens/Appointments/Current/currentappointments.dart';
import 'package:virtualQ/UI/screens/Appointments/New/selectbank.dart';
import 'package:virtualQ/UI/screens/Appointments/New/token_creation.dart';
import 'package:virtualQ/UI/screens/Login/forgotpass.dart';
import 'package:virtualQ/UI/screens/Login/login.dart';
import 'package:virtualQ/UI/screens/Registeration/otp_verification.dart';
import 'package:virtualQ/UI/screens/Registeration/registeration.dart';
import 'package:virtualQ/UI/screens/Token/token_generated.dart';
import 'package:virtualQ/UI/screens/Verification/verification.dart';
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
        MobileVerification(),
  );
  static Handler _otpVerificationHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
        OtpVerification(),
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
        NewAppointment(),
  );
  static Handler _tokenSuccess = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
        TokenSuccess(),
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
      'otp',
      handler: _otpHandler,
    );
    router.define(
      'otpverification',
      handler: _otpVerificationHandler,
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
      'tokenform',
      handler: _tokenForm,
    );
    router.define(
      'tokensuccess',
      handler: _tokenSuccess,
    );
  }
}
