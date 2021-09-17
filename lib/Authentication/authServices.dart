import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:timepass/API/BasicAPI.dart';

import 'package:timepass/Authentication/mobileNoAuthScreen.dart';
import 'package:timepass/Widgets/bottomNavigationWidget.dart';
import 'package:http/http.dart' as http;
import '../main.dart';

class AuthService {
  Future<User?> signInWithGoogle(
    BuildContext context,
  ) async {
    try {
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      UserCredential authResult = await auth.signInWithCredential(credential);
      userCurrent = authResult.user;
      User? value = authResult.user;
      if (value != null) {
        var url = Uri.parse('$weburl/user/othersignup');
        var response = await http.post(url, body: {
          'email': userCurrent!.email,
        });
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          xAccessToken = data['token'];
          userid = data["result"]["_id"];
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return BottomNavigationBarWidget();
          }));
        } else if (response.statusCode == 500) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return MobileNumberAuthScreen(
              email: value.email,
              imageurl: value.photoURL,
              name: value.displayName,
              typeOfSignup: "Google",
              userid: value.uid,
              credential: credential,
              password: "",
            );
            //   // BottomNavigationBarWidget();
          }));
        } else {
          errorDialog(
            context,
            'Oops! Something went wrong.',
          );
        }
      }
      // return authResult.user;
    } catch (e) {
      errorDialog(
        context,
        'Oops! Something went wrong.',
      );
    }
  }

  Future<User?> signinwithFacebook(BuildContext context) async {
    try {
      final LoginResult result = await facebookAuth.login();

      switch (result.status) {
        case LoginStatus.success:
          final AuthCredential facebookCredential =
              FacebookAuthProvider.credential(result.accessToken!.token);
          final userCredential = await FirebaseAuth.instance
              .signInWithCredential(facebookCredential);
          User? value = userCredential.user;
          if (value != null) {
            var url = Uri.parse('$weburl/user/othersignup');
            var response = await http.post(url, body: {
              'email': userCurrent!.email,
            });
            if (response.statusCode == 200) {
              var data = jsonDecode(response.body);
              xAccessToken = data['token'];
              userid = data["result"]["_id"];
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return BottomNavigationBarWidget();
              }));
            } else if (response.statusCode == 500) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return MobileNumberAuthScreen(
                  email: value.email,
                  imageurl: value.photoURL,
                  name: value.displayName,
                  typeOfSignup: "Facebook",
                  userid: value.uid,
                  credential: facebookCredential,
                  password: "",
                );
                //   // BottomNavigationBarWidget();
              }));
            } else {
              errorDialog(
                context,
                'Oops! Something went wrong.',
              );
            }
          }
          break;
        case LoginStatus.cancelled:
          return null;
        case LoginStatus.failed:
          return null;
        default:
          return null;
      }

      // final AuthCredential facebookCredential =
      //     FacebookAuthProvider.credential(result.accessToken!.token);
      // final UserCredential userCredential =
      //     await auth.signInWithCredential(facebookCredential);
      // return userCredential.user;
    } catch (e) {
      errorDialog(context, 'Oops! Something went wrong.');
    }
  }

  Future<void> signUp(email, password, BuildContext context) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      User? value = userCredential.user;
      if (value != null) {
        // UserCredential cred = await auth.signInWithEmailAndPassword(
        //     email: email, password: password);

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return MobileNumberAuthScreen(
            email: value.email,
            imageurl: value.photoURL,
            name: value.displayName,
            typeOfSignup: "Email",
            userid: value.uid,
            credential: userCredential.credential,
            password: password,
          );
          //   // BottomNavigationBarWidget();
        }));
      }
      // return users;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "ERROR_OPERATION_NOT_ALLOWED":
          errorDialog(context, "Anonymous accounts are not enabled");
          break;
        case "ERROR_WEAK_PASSWORD":
          errorDialog(context, "Your password is too weak");

          break;
        case "ERROR_INVALID_EMAIL":
          errorDialog(context, "Your email is invalid");

          break;
        case "ERROR_EMAIL_ALREADY_IN_USE":
          errorDialog(context, "Email is already in use on different account");

          break;
        case "ERROR_INVALID_CREDENTIAL":
          errorDialog(context, "Your email is invalid");

          break;

        default:
          errorDialog(context, "Something went wrong.");
      }
    } catch (e) {
      errorDialog(context, "Something went wrong.");
    }
  }

  Future<void> signIn(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      userCurrent = userCredential.user;
      if (userCurrent != null) {
        var url = Uri.parse('$weburl/user/othersignup');
        var response = await http.post(url, body: {
          'email': userCurrent!.email,
        });
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          xAccessToken = data['token'];
          userid = data["result"]["_id"];
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return BottomNavigationBarWidget();
          }));
        } else {
          errorDialog(context, "Something went wrong.");
        }
      } else {
        errorDialog(context, "Something went wrong.");
      }
      // return user;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      switch (e.code) {
        case "ERROR_EMAIL_ALREADY_IN_USE":
        case "account-exists-with-different-credential":
        case "email-already-in-use":
          errorDialog(context, "Email already used. Go to login page.");
          break;
        case "ERROR_WRONG_PASSWORD":
        case "wrong-password":
          errorDialog(context, "Wrong email/password combination.");

          break;
        case "ERROR_USER_NOT_FOUND":
        case "user-not-found":
          errorDialog(context, "No user found with this email. Please signup.");

          break;
        case "ERROR_USER_DISABLED":
        case "user-disabled":
          errorDialog(context, "User disabled.");

          break;
        case "ERROR_TOO_MANY_REQUESTS":
        case "operation-not-allowed":
          errorDialog(context, "Too many requests to log into this account.");

          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
        case "operation-not-allowed":
          errorDialog(context, "Server error, please try again later.");

          break;
        case "ERROR_INVALID_EMAIL":
        case "invalid-email":
          errorDialog(context, "Email address is invalid.");

          break;
        default:
          errorDialog(context, "Login failed. Please try again.");

          break;
      }
    } catch (e) {
      errorDialog(context, "Something went wrong");
    }
  }

  Future errorDialog(
    BuildContext context,
    String title,
  ) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text(
              title,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.02,
              ),
            ),
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Okay'),
              ),
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          );
        });
  }
}
