import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timepass/Authentication/SignUpScreen.dart';
import 'package:timepass/Authentication/createUserProfile.dart';
import 'package:timepass/Authentication/mobileNoAuthScreen.dart';
import 'package:timepass/Screens/home_Screen.dart';
import 'package:timepass/Utils/colors.dart';
import 'package:timepass/Widgets/bottomNavigationWidget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarIconBrightness: Brightness.dark),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Timepass',
      theme: themeData,
      themeMode: ThemeMode.light,
      home: CreateUserProfile(),
    );
  }
}
