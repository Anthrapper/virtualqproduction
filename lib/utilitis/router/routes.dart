import 'package:get/get.dart';
import 'package:virtualq/Services/Controllers/Splash_Screen/splash_binding.dart';
import 'package:virtualq/UI/screens/Appointments/Current/currentappointments.dart';
import 'package:virtualq/UI/screens/Appointments/New/selectbank.dart';
import 'package:virtualq/UI/screens/Appointments/New/token_creation.dart';
import 'package:virtualq/UI/screens/Login/forgot_pass/forgotpass.dart';
import 'package:virtualq/UI/screens/Login/forgot_pass/forgot_otpverify.dart';
import 'package:virtualq/UI/screens/Login/login.dart';
import 'package:virtualq/UI/screens/Login/forgot_pass/password_reset.dart';
import 'package:virtualq/UI/screens/Login/verify_account/verify_account.dart';
import 'package:virtualq/UI/screens/Registeration/otp_verification.dart';
import 'package:virtualq/UI/screens/Registeration/registeration.dart';
import 'package:virtualq/UI/screens/Token/detailed_token.dart';
import 'package:virtualq/UI/screens/home/home.dart';
import 'package:virtualq/UI/screens/welcome_screen/splash_screen.dart';
import 'package:virtualq/UI/screens/welcome_screen/welcomescreen.dart';

class Routes {
  static final route = [
    GetPage(
      name: '/login',
      page: () => LoginPage(),
    ),
    GetPage(
      name: '/register',
      page: () => SignUpForm(),
    ),
    GetPage(
      name: '/apphome',
      page: () => WelcomeScreen(),
    ),
    GetPage(
      name: '/home',
      page: () => HomePage(),
    ),
    GetPage(
      name: '/forgotpass',
      page: () => ForgotPass(),
    ),
    GetPage(
      name: '/passwordreset',
      page: () => PasswordReset(),
    ),
    GetPage(
      name: '/splashscreen',
      page: () => SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: '/currentappointments',
      page: () => CurrentAppointments(),
    ),
    GetPage(
      name: '/bankselection',
      page: () => SelectBank(),
    ),
    GetPage(
      name: '/detailedtoken',
      page: () => DetailedToken(),
    ),
    GetPage(
      name: '/verify',
      page: () => VerifyAccount(),
    ),
    GetPage(
      name: '/regverification/:phone',
      page: () => OtpVerification(),
    ),
    GetPage(
      name: '/otp/:phone',
      page: () => ForgotOtpVerification(),
    ),
    GetPage(
      name: '/tokengen/:branch',
      page: () => NewAppointment(),
    ),
  ];
}
