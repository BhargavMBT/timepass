import 'package:flutter/material.dart';
import 'package:timepass/Widgets/bottomNavigationWidget.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({Key? key}) : super(key: key);

  @override
  _UpdatePasswordState createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  TextEditingController newpasswordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();

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
      child: TextFormField(
        keyboardType: TextInputType.number,
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintext,
        ),
      ),
    );
  }

  Widget updateButton(double height, double width) {
    return GestureDetector(
      onTap: () {
         Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return BottomNavigationBarWidget();
        }));
      },
      child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: width * 0.22, vertical: height * 0.02),
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
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(colors: [
                Color.fromRGBO(39, 39, 39, 1),
                Color.fromRGBO(39, 39, 39, 0.28),
              ])),
          child: Text("Update password",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ))),
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Material(
      child: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  height: height * 0.5,
                  width: double.infinity,
                  child: Image.asset(
                    "assets/images/login2.jpg",
                  )),
              textfields(
                height,
                width,
                "New password",
                true,
                newpasswordController,
              ),
              textfields(
                height,
                width,
                "Confirm password",
                true,
                confirmpasswordController,
              ),
              updateButton(height, width),
            ],
          ),
        ),
      ),
    );
  }
}
