import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:timepass/Authentication/OtpVerification.dart';

import 'package:timepass/Authentication/authServices.dart';
import 'package:timepass/Authentication/createUserProfile.dart';

import 'package:timepass/Widgets/bottomNavigationWidget.dart';
import 'package:timepass/main.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class MobileNumberAuthScreen extends StatefulWidget {
  final String? name;
  final String? imageurl;
  final String? userid;
  final String? email;
  final String? typeOfSignup;
  final AuthCredential? credential;
  final String? password;

  MobileNumberAuthScreen({
    this.name,
    this.imageurl,
    this.email,
    this.userid,
    this.typeOfSignup,
    this.credential,
    this.password,
  });

  @override
  _MobileNumberAuthScreenState createState() => _MobileNumberAuthScreenState();
}

class _MobileNumberAuthScreenState extends State<MobileNumberAuthScreen> {
  // int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 45;
  // CountdownTimerController? controller =  CountdownTimerController(
  //     endTime: endTime,
  //     onEnd: timeend,
  //   );
  String? verficationid;
  bool isloading = false;
  int? forceResendingtoken;
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;
  TextEditingController mobileController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future timeend() async {
    // AuthService().errorDialog(context, "Time out of the ");
    setState(() {
      currentState = MobileVerificationState.SHOW_MOBILE_FORM_STATE;
    });
  }

  Future mobileAuthentication(String phonenumber, BuildContext context) async {
    setState(() {
      isloading = true;
    });
    mobileAuth.verifyPhoneNumber(
        phoneNumber: phonenumber,
        timeout: Duration(seconds: 45),
        verificationCompleted: (AuthCredential authCredential) {
          mobileAuth
              .signInWithCredential(authCredential)
              .then((UserCredential result) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => BottomNavigationBarWidget()));
          }).catchError((e) {
            AuthService().errorDialog(context, "Soemething went wrong");
          });
        },
        verificationFailed: (FirebaseAuthException authException) {
          setState(() {
            currentState = MobileVerificationState.SHOW_MOBILE_FORM_STATE;
            isloading = false;
          });
          if (authException.message == 'invalid-phone-number') {
            AuthService().errorDialog(
                context, 'The provided phone number is not valid.');
          }

          AuthService().errorDialog(context, authException.message.toString());
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          setState(() {
            isloading = false;
            forceResendingtoken = forceResendingToken;
            verficationid = verificationId;
            currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
          });
        },
        codeAutoRetrievalTimeout: (String s) {});
  }

  Future resendAuthentication(
      String phonenumber, BuildContext context, int resendToeken) async {
    setState(() {
      isloading = true;
    });
    mobileAuth.verifyPhoneNumber(
        phoneNumber: phonenumber,
        forceResendingToken: resendToeken,
        timeout: Duration(seconds: 45),
        verificationCompleted: (AuthCredential authCredential) {
          mobileAuth
              .signInWithCredential(authCredential)
              .then((UserCredential result) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => CreateUserProfile(
                          email: widget.email,
                          imageurl: widget.imageurl,
                          name: widget.name,
                          typeOfSignup: widget.typeOfSignup,
                          userid: widget.userid,
                        )));
          }).catchError((e) {
            AuthService().errorDialog(context, "Soemething went wrong");
          });
        },
        verificationFailed: (FirebaseAuthException authException) {
          if (authException.message == 'invalid-phone-number') {
            AuthService().errorDialog(
                context, 'The provided phone number is not valid.');
          }

          AuthService().errorDialog(context, authException.message.toString());
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          setState(() {
            isloading = false;
            forceResendingtoken = forceResendingToken;
            verficationid = verificationId;
            currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
          });
        },
        codeAutoRetrievalTimeout: (String s) {});
  }

  Widget textfields(
    double height,
    double width,
    String hintext,
    bool obscureText,
    TextEditingController controller,
  ) {
    return Container(
      height: height * 0.066,
      padding: EdgeInsets.only(
        left: width * 0.04,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
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
      child: Row(children: [
        Text("+91"),
        SizedBox(
          width: width * 0.03,
        ),
        Expanded(
          child: TextFormField(
            keyboardType: TextInputType.number,
            controller: controller,
            obscureText: obscureText,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(
                RegExp(r'[0-9]'),
              ),
            ],
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintext,
            ),
          ),
        ),
      ]),
    );
  }

  Widget getOtpButton(double height, double width) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (BuildContext context) {
        //   return OtpVerification();
        // }));
        if (mobileController.text.trim().isNotEmpty &&
            mobileController.text.trim().length == 10) {
          setState(() {
            isloading = true;
          });
          mobileAuthentication("+91" + mobileController.text, context);
          setState(() {
            isloading = false;
          });
        } else {
          AuthService().errorDialog(context, "Enter a correct mobile number");
        }
      },
      child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: width * 0.26, vertical: height * 0.02),
          height: height * 0.05,
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
          child: Text("Get OTP",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ))),
    );
  }

  String otp = "";
  Widget verifyButton(
    double height,
    double width,
  ) {
    return GestureDetector(
      onTap: () async {
        if (otp.trim().length == 6) {
          try {
            setState(() {
              isloading = true;
            });
            final code = otp.trim();
            AuthCredential credential = PhoneAuthProvider.credential(
              verificationId: verficationid!,
              smsCode: code,
            );

            UserCredential result =
                await mobileAuth.signInWithCredential(credential);

            User? user = result.user;

            if (user != null) {
              // await mobileAuth.signOut();
              if (widget.typeOfSignup == "Email") {
                await auth.signInWithEmailAndPassword(
                    email: widget.email!, password: widget.password!);

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateUserProfile(
                      phoneNumber: mobileController.text,
                      email: widget.email,
                      imageurl: widget.imageurl,
                      name: widget.name,
                      typeOfSignup: widget.typeOfSignup,
                      userid: widget.userid,
                    ),
                  ),
                );
              } else {
                print(widget.credential!);
                await auth.signInWithCredential(widget.credential!);

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateUserProfile(
                      phoneNumber: mobileController.text,
                      email: widget.email,
                      imageurl: widget.imageurl,
                      name: widget.name,
                      typeOfSignup: widget.typeOfSignup,
                      userid: widget.userid,
                    ),
                  ),
                );
              }
            } else {
              print("Error");
            }
            setState(() {
              isloading = true;
            });
          } on FirebaseAuthException catch (e) {
            AuthService().errorDialog(context, e.code);
          } catch (e) {
            print(e.toString());
            setState(() {
              currentState = MobileVerificationState.SHOW_MOBILE_FORM_STATE;
            });
            AuthService().errorDialog(context, "Something went wrong!");
          } finally {
            setState(() {
              isloading = false;
            });
          }
        } else {
          AuthService().errorDialog(context, "Enter a correct OTP.");
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: width * 0.26, vertical: height * 0.01),
        height: height * 0.05,
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
          "Verify",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  // countdowntimer(double height, double width) {
  //   return Container(
  //     child: CountdownTimer(
  //       endTime: endTime,
  //       controller: controller,
  //       onEnd: timeend,
  //       widgetBuilder: (BuildContext context, time) {
  //         return time == null
  //             ? Container()
  //             : Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   Text(
  //                     time.sec.toString(),
  //                     style: TextStyle(
  //                       color: Colors.black,
  //                       fontSize: 16,
  //                       fontWeight: FontWeight.w600,
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     width: width * 0.01,
  //                   ),
  //                   Icon(
  //                     Icons.timer,
  //                     color: Colors.black,
  //                   )
  //                 ],
  //               );
  //       },
  //       endWidget: Container(),
  //     ),
  //   );
  // }

  Widget otpScreen(double height, double width) {
    return Material(
        color: Colors.white,
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: height * 0.5,
                  width: double.infinity,
                  child: Image.asset(
                    "Assets/Images/login.jpg",
                  ),
                ),
                // countdowntimer(height, width),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: width * 0.1,
                  ),
                  child: OTPTextField(
                    length: 6,
                    width: width,
                    fieldWidth: width * 0.1,
                    style: TextStyle(fontSize: 17),
                    textFieldAlignment: MainAxisAlignment.spaceBetween,
                    fieldStyle: FieldStyle.underline,
                    outlineBorderRadius: 10,
                    onChanged: (String? pin) {},
                    otpFieldStyle: OtpFieldStyle(
                      borderColor: Colors.black,
                      enabledBorderColor: Colors.black,
                    ),
                    keyboardType: TextInputType.number,
                    onCompleted: (String? pin) {
                      if (pin != null && pin.isNotEmpty) {
                        setState(() {
                          otp = pin;
                        });
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                verifyButton(height, width),
                SizedBox(
                  height: height * 0.025,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Did’t recieve the OTP?",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: width * 0.015),
                      GestureDetector(
                        onTap: () {
                          if (forceResendingtoken != null) {
                            resendAuthentication("+91" + mobileController.text,
                                context, forceResendingtoken!);
                          } else {
                            setState(() {
                              currentState = MobileVerificationState
                                  .SHOW_MOBILE_FORM_STATE;
                            });
                          }
                        },
                        child: Text(
                          "Resend OTP",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Material(
      color: Colors.white,
      child: currentState == MobileVerificationState.SHOW_OTP_FORM_STATE
          ? Stack(
              children: [
                otpScreen(height, width),
                isloading
                    ? Center(
                        child: CircularProgressIndicator(
                        backgroundColor: Colors.grey[800],
                        valueColor: AlwaysStoppedAnimation(Colors.blue),
                      ))
                    : Container(),
              ],
            )
          : Stack(
              children: [
                Container(
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                            height: height * 0.5,
                            width: double.infinity,
                            child: Image.asset(
                              "Assets/Images/login2.jpg",
                            )),
                        textfields(
                          height,
                          width,
                          "Enter your mobile number",
                          false,
                          mobileController,
                        ),
                        getOtpButton(height, width),
                      ],
                    ),
                  ),
                ),
                isloading
                    ? Center(
                        child: CircularProgressIndicator(
                        backgroundColor: Colors.grey[800],
                        valueColor: AlwaysStoppedAnimation(Colors.blue),
                      ))
                    : Container(),
              ],
            ),
    );
  }
}
