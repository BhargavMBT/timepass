import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

import 'package:timepass/Widgets/bottomNavigationWidget.dart';

class OtpVerification extends StatefulWidget {
  final String? verficationId;
  OtpVerification({this.verficationId});

  @override
  _OtpVerificationState createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  Widget verifyButton(double height, double width) {
    return GestureDetector(
      onTap: () async {
        // final code = otp.trim();
        // AuthCredential credential = PhoneAuthProvider.credential(
        //     verificationId: widget.verficationId!, smsCode: code);
        // // getCredential(
        // //     verificationId: widget.verficationId, smsCode: code);

        // UserCredential result =
        //     await AuthService().auth.signInWithCredential(credential);

        // User? user = result.user;

        // if (user != null) {
        //   Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //           builder: (context) => BottomNavigationBarWidget()));
        // } else {
        //   print("Error");
        // }

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return BottomNavigationBarWidget();
        }));
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
          child: Text("Verify",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ))),
    );
  }

  String otp = "";
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Material(
      color: Colors.black,
      child: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  height: height * 0.5,
                  width: double.infinity,
                  child: Image.asset(
                    "assets/images/login.jpg",
                  )),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: width * 0.17,
                ),
                child: OTPTextField(
                  length: 4,
                  width: width,
                  fieldWidth: width * 0.1,
                  style: TextStyle(fontSize: 17),
                  textFieldAlignment: MainAxisAlignment.spaceBetween,
                  fieldStyle: FieldStyle.underline,
                  outlineBorderRadius: 10,
                  otpFieldStyle: OtpFieldStyle(
                    borderColor: Colors.black,
                    enabledBorderColor: Colors.black,
                  ),
                  onCompleted: (String? pin) {
                    if (pin != null) {
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
                    Text(
                      "Resend OTP",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
