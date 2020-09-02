import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virtualQ/utilitis/router/routes.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: Router.route,
      initialRoute: '/splashscreen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.lato().fontFamily,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: Colors.lightBlue[700],
        textTheme: TextTheme().apply(fontFamily: GoogleFonts.lato().fontFamily),
      ),
    );
  }
}
