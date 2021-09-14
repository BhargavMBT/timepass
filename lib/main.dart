import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:timepass/API/BasicAPI.dart';
import 'package:timepass/Authentication/SignUpScreen.dart';
import 'package:timepass/Authentication/createUserProfile.dart';
import 'package:timepass/Authentication/mobileNoAuthScreen.dart';
import 'package:timepass/Screens/home_Screen.dart';
import 'package:timepass/Utils/colors.dart';
import 'package:timepass/Widgets/bottomNavigationWidget.dart';
import 'package:timepass/Widgets/progressIndicators.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // @override
  // void initState() {
  //   auth.signOut();
  //   super.initState();
  // }

  // Stream getUser(String? email, String? name) async* {
  //   try {
  //     var url = Uri.parse('$weburl/user/othersignup');
  //     var response = await http.post(url, body: {
  //       'email': email,
  //     });
  //     if (response.statusCode == 200) {
  //       yield response.body;
  //     } else {
  //       throw Exception("Something went wrong");
  //     }
  //   } catch (e) {
  //     throw Exception("Something went wrong");
  //   }
  // }
  Future getUser(String? email, String? name) async {
    try {
      var url = Uri.parse('$weburl/user/othersignup');
      var response = await http.post(url, body: {
        'email': email,
      });
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception("Something went wrong");
      }
    } catch (e) {
      throw Exception("Something went wrong");
    }
  }

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
      home:
          // CreateUserProfile(),
          StreamBuilder(
        stream: auth.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            userCurrent = snapshot.data;
            // print(userCurrent!.phoneNumber);
            // print(userCurrent!.email.toString() + "email");
            if (userCurrent == null) {
              return SignUpScreen();
            } else {
              return FutureBuilder(
                future: getUser(userCurrent!.email, userCurrent!.displayName),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                        color: Colors.white,
                        alignment: Alignment.center,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10)),
                          height: MediaQuery.of(context).size.height * 0.08,
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Just a second",
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.035,
                              ),
                              Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.03,
                                  width:
                                      MediaQuery.of(context).size.width * 0.06,
                                  child: circularProgressIndicator()),
                            ],
                          ),
                        ));
                  } else if (snapshot.hasData) {
                    var data = jsonDecode(snapshot.data);
                    xAccessToken = data['token'];
                    userid = data["result"]["_id"];
                    return BottomNavigationBarWidget();
                  } else {
                    return CreateUserProfile();
                  }
                },
              );
            }
            // print(userCurrent!.displayName.toString());
            // print(userCurrent!.email.toString());
            // print(userCurrent!.uid);
            // return Container(
            //   color: Colors.white,
            // );

          } else if (snapshot.connectionState == ConnectionState.none) {
            return SignUpScreen();
          } else {
            return Container(
              alignment: Alignment.center,
              child: circularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

String? xAccessToken;
String? userid;
final Reference storage = FirebaseStorage.instance.ref();
final FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseAuth mobileAuth = FirebaseAuth.instance;
final FacebookAuth facebookAuth = FacebookAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
User? userCurrent;
