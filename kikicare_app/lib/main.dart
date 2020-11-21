import 'package:flutter/material.dart';
import 'package:kikicare_app/ui/Auth/Login.dart';
import 'package:kikicare_app/ui/splash.dart';
import 'package:kikicare_app/util/constants.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KiKiCare',
      theme: ThemeData(
        fontFamily: "Cairo",
        scaffoldBackgroundColor: kBackgroundColor,
        textTheme: Theme.of(context).textTheme.apply(displayColor: kTextColor),
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

