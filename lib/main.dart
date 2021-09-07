import 'package:flutter/material.dart';
import '/screens/Main/main_screen.dart';
import '/constraints.dart';
import '/screens/auth/login_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const id = "home";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        fontFamily: kPrimaryFont,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        accentColor: kPrimaryColor,

      ),


      home: LoginScreen(),
      //LoginScreen(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],

      supportedLocales: [
        Locale("ar"),
      ],
    );
  }
}
