import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timepass/Authentication/OtpVerification.dart';
import 'package:timepass/Authentication/authServices.dart';
import 'package:timepass/Authentication/mobileNoAuthScreen.dart';
import 'package:timepass/Widgets/bottomNavigationWidget.dart';

enum TypeOfAuthentication { Signin, Signup }

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TypeOfAuthentication authentication = TypeOfAuthentication.Signup;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmPasswordcontroller = TextEditingController();

  bool passwordShow = true;
  bool confrimPasswordShow = true;
  bool passwordObscreTExt = true;
  bool confirmPasswordObscureText = true;

  Widget textfields(
    double height,
    double width,
    String hintext,
    bool obscureText,
    TextEditingController controller,
    bool eyeWidget,
    String field,
    bool eye,
  ) {
    return Container(
      height: height * 0.066,
      padding: EdgeInsets.only(
        left: width * 0.04,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(35),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(111, 111, 111, 0.24),
              offset: Offset(8, 8),
              blurRadius: 44,
              spreadRadius: 0,
            ),
          ]),
      margin: EdgeInsets.symmetric(
          horizontal: width * 0.04, vertical: height * 0.025),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintext,
          suffixIcon: eyeWidget
              ? IconButton(
                  onPressed: () {
                    if (field == "password") {
                      setState(() {
                        passwordShow = !passwordShow;
                        passwordObscreTExt = !passwordObscreTExt;
                      });
                    } else if (field == "confirmPassword") {
                      setState(() {
                        confrimPasswordShow = !confrimPasswordShow;
                        confirmPasswordObscureText =
                            !confirmPasswordObscureText;
                      });
                    }
                  },
                  icon: !eye
                      ? Icon(
                          EvaIcons.eye,
                        )
                      : Icon(EvaIcons.eyeOff),
                )
              : Container(
                  height: 0,
                  width: 0,
                ),
        ),
      ),
    );
  }

  Widget signupButton(
      double height, double width, TypeOfAuthentication authType) {
    return GestureDetector(
      onTap: () {
        if (authType == TypeOfAuthentication.Signup) {
          print("sign up");
          bool emailValid = RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(emailcontroller.text);
          if (emailValid) {
            if (passwordcontroller.text.isNotEmpty &&
                confirmPasswordcontroller.text.isNotEmpty) {
              if (passwordcontroller.text == confirmPasswordcontroller.text) {
                setState(() {
                  isloading = true;
                });
                AuthService()
                    .signUp(
                        emailcontroller.text, passwordcontroller.text, context)
                    .then((value) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return MobileNumberAuthScreen(
                      email: value!.email,
                      imageurl: value.photoURL,
                      name: value.displayName,
                      typeOfSignup: "Email",
                      userid: value.uid,
                    );
                    // BottomNavigationBarWidget();
                  }));
                });
                setState(() {
                  isloading = false;
                });
              } else {
                AuthService()
                    .errorDialog(context, "Confirm password is not match");
              }
            } else {
              AuthService().errorDialog(context, "Enter a password.");
            }
          } else {
            AuthService().errorDialog(context, "Enter valid email address.");
          }
        } else {
          print("sign in");
          bool emailValid = RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(emailcontroller.text);
          if (emailValid) {
            if (passwordcontroller.text.trim().isNotEmpty) {
              setState(() {
                isloading = true;
              });
              AuthService()
                  .signIn(emailcontroller.text.trim(), passwordcontroller.text,
                      context)
                  .then((value) {
                if (value != null) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return BottomNavigationBarWidget();
                      },
                    ),
                  );
                }
              });
              setState(() {
                isloading = false;
              });
            } else {
              AuthService().errorDialog(context, "Enter a password.");
            }
          } else {
            AuthService().errorDialog(context, "Enter valid email address.");
          }
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: width * 0.25, vertical: height * 0.01),
        height: height * 0.06,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(111, 111, 111, 0.24),
                offset: Offset(8, 8),
                blurRadius: 44,
                spreadRadius: 0,
              ),
            ],
            borderRadius: BorderRadius.circular(35),
            gradient: LinearGradient(colors: [
              Color.fromRGBO(39, 39, 39, 1),
              Color.fromRGBO(39, 39, 39, 0.28),
            ])),
        child: Text(
          authType == TypeOfAuthentication.Signup ? "Sign up" : "Sign in",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget titleText(String title) {
    return Container(
        alignment: Alignment.center,
        child: Text(title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            )));
  }

  Widget icon(double height, double width, IconData icon) {
    return Container(
      height: height * 0.1,
      width: width * 0.1,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(105, 101, 101, 0.25),
              offset: Offset(0, 4),
              blurRadius: 32,
              spreadRadius: 0,
            )
          ]),
      alignment: Alignment.center,
      child: Icon(
        icon,
      ),
    );
  }

  Widget optionsOfSignup(double height, double width) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isloading = true;
              });
              AuthService().signInWithGoogle(context).then(
                (User? value) {
                  if (value != null) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return MobileNumberAuthScreen(
                        email: value.email,
                        imageurl: value.photoURL,
                        name: value.displayName,
                        typeOfSignup: "Google sign in",
                        userid: value.uid,
                      );
                      // BottomNavigationBarWidget();
                    }));
                  } else {
                    AuthService().errorDialog(context, "Something went wrong.");
                  }
                },
              );
              setState(() {
                isloading = false;
              });
            },
            child: icon(
              height,
              width,
              EvaIcons.google,
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isloading = true;
              });
              AuthService().signinwithFacebook(context).then(
                (User? value) {
                  if (value != null) {
                    print(value.email);
                    print(value.displayName);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return MobileNumberAuthScreen(
                        email: value.email,
                        imageurl: value.photoURL,
                        name: value.displayName,
                        typeOfSignup: "Facebook",
                        userid: value.uid,
                      );
                      // BottomNavigationBarWidget();
                    }));
                  } else {
                    AuthService()
                        .errorDialog(context, "Oops! Something went wrong.");
                  }
                },
              );
              setState(() {
                isloading = false;
              });
            },
            child: icon(
              height,
              width,
              EvaIcons.facebook,
            ),
          ),
          icon(
            height,
            width,
            EvaIcons.twitter,
          ),
        ],
      ),
    );
  }

  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Material(
        color: Colors.white,
        child: Stack(
          children: [
            Container(
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.07,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (authentication == TypeOfAuthentication.Signin) {
                          setState(() {
                            authentication = TypeOfAuthentication.Signup;
                          });
                        } else {
                          setState(() {
                            authentication = TypeOfAuthentication.Signin;
                          });
                        }
                      },
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          height: height * 0.05,
                          width: width * 0.21,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(111, 111, 111, 0.24),
                                offset: Offset(8, 8),
                                blurRadius: 10,
                                spreadRadius: 0,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(16),
                            gradient: LinearGradient(colors: [
                              Color.fromRGBO(38, 203, 255, 1),
                              Color.fromRGBO(105, 128, 253, 1),
                            ]),
                          ),
                          margin: EdgeInsets.only(right: width * 0.04),
                          alignment: Alignment.center,
                          child: Text(
                            authentication == TypeOfAuthentication.Signin
                                ? "Signup"
                                : "SignIn",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.08,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: width * 0.06,
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text(
                          authentication == TypeOfAuthentication.Signin
                              ? "SignIn an account"
                              : "Create an account",
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          )),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    textfields(height, width, "Enter email address", false,
                        emailcontroller, false, "email", false),
                    textfields(
                        height,
                        width,
                        "Enter password",
                        passwordObscreTExt,
                        passwordcontroller,
                        true,
                        "password",
                        passwordShow),
                    authentication == TypeOfAuthentication.Signup
                        ? textfields(
                            height,
                            width,
                            "Confirm password",
                            confirmPasswordObscureText,
                            confirmPasswordcontroller,
                            true,
                            "confirmPassword",
                            confrimPasswordShow)
                        : Container(),
                    signupButton(height, width, authentication),
                    SizedBox(
                      height: height * 0.08,
                    ),
                    titleText("Or"),
                    authentication == TypeOfAuthentication.Signin
                        ? titleText("Sign in with")
                        : titleText("Sign up with"),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    optionsOfSignup(height, width),
                    Container(
                      height: height * 0.05,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            isloading
                ? Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.grey[800],
                      valueColor: AlwaysStoppedAnimation(Colors.blue),
                    ),
                  )
                : Container(),
          ],
        ));
  }
}
