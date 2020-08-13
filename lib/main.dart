import 'package:flutter/material.dart';
import 'package:virtualQ/UI/screens/welcome_screen/welcomescreen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomeScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.lato().fontFamily,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: Colors.white,
        textTheme: TextTheme().apply(fontFamily: GoogleFonts.lato().fontFamily),
      ),
    );
  }
}
