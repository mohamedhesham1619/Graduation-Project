import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:text_analysis/Constants/constants.dart';
import 'package:text_analysis/Provider/app_provider.dart';
import 'package:text_analysis/Screens/launch_screen/launch_screen.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (ctx) => AppProvider(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QCA',
      theme: ThemeData(
        textTheme: TextTheme(
          headline1: TextStyle(
            fontFamily: GoogleFonts.playfairDisplay().fontFamily,
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          headline2: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          subtitle1: TextStyle(
            color: Colors.black.withOpacity(.65),
            fontSize: 15,
          ),
          subtitle2: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          bodyText1: TextStyle(
            color: primaryColor,
            fontSize: 25,
            fontWeight: FontWeight.normal,
          ),
          button: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
      home: LaunchScreen(),
    );
  }
}
