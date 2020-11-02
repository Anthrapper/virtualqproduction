import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtualQ/Services/Controllers/Translations/translations.dart';
import 'package:virtualQ/utilitis/router/routes.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String stringValue = prefs.getString('lang');
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp(
      language: stringValue,
    ));
  });
}

class MyApp extends StatelessWidget {
  final String language;
  MyApp({this.language});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: Routes.route,
      initialRoute: '/splashscreen',
      debugShowCheckedModeBanner: false,
      translations: Messages(),
      locale: this.language == null ? Locale('en') : Locale(this.language),
      theme: ThemeData(
        fontFamily: GoogleFonts.lato().fontFamily,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: Colors.lightBlue[700],
        textTheme: TextTheme().apply(fontFamily: GoogleFonts.lato().fontFamily),
      ),
    );
  }
}
