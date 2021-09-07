import 'dart:async';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:timepass/Authentication/authServices.dart';
import 'package:timepass/Utils/colors.dart';
import 'package:timepass/Utils/textTitleWidgets.dart';
import 'package:http/http.dart' as http;
import 'package:timepass/Widgets/bottomNavigationWidget.dart';

class CreateUserProfile extends StatefulWidget {
  final String? name;
  final String? imageurl;
  final String? userid;
  final String? email;
  final String? typeOfSignup;

  CreateUserProfile(
      {this.name, this.imageurl, this.email, this.userid, this.typeOfSignup});

  @override
  _CreateUserProfileState createState() => _CreateUserProfileState();
}

class _CreateUserProfileState extends State<CreateUserProfile> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    if (widget.name != null) {
      controller.text = widget.name!;
    }
    super.initState();
  }

  OutlineInputBorder border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: blackColor,
      ),
    );
  }

  imageheader(double height, double width) {
    return Stack(
      children: [
        Container(
            height: height * 0.15,
            width: width * 0.3,
            decoration: widget.imageurl == null
                ? BoxDecoration(
                    color: Colors.grey[300],
                    shape: BoxShape.circle,
                  )
                : BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        widget.imageurl!,
                      ),
                    ),
                  )),
        Positioned(
          top: height * 0.08,
          right: width * 0.01,
          child: Container(
            height: height * 0.08,
            width: width * 0.08,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey[300]!,
                width: 0.5,
              ),
              color: whiteColor,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(
              EvaIcons.edit,
              size: height * 0.022,
            ),
          ),
        )
      ],
    );
  }

  nameTextfiled(double height, double width) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: width * 0.04, vertical: height * 0.06),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: border(),
          focusedBorder: border(),
          errorBorder: border(),
          disabledBorder: border(),
          hintText: "Enter your name.",
          labelText: "Name",
        ),
      ),
    );
  }

  Future postUserData() async {
    setState(() {
      loading = true;
    });
    try {
      var weburl = "https://socioclub-api.herokuapp.com";

      var url = Uri.parse('$weburl/user/othersignup');
      var response = await http.post(url, body: {
        'email': 'milindvaghasiya6@gmail.com',
        'name': 'Milind',
      });

      if (response.statusCode == 200) {
        setState(() {
          loading = false;
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return BottomNavigationBarWidget();
            },
          ),
        );
      } else {
        AuthService().errorDialog(
          context,
          "Oops! Something went wrong",
        );
      }
    } catch (e) {
      AuthService().errorDialog(
        context,
        "Oops! Something went wrong",
      );
    } finally {
      setState(() {
        loading = false;
      });
    }
    // print('Response status: ${}');
    // print('Response body: ${response.body}');
  }

  button(double height, double width) {
    return GestureDetector(
      onTap: postUserData,
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
          "Create profile",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    // print(widget.name);
    // print(widget.email);
    // print(widget.imageurl);
    // print(widget.userid);

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Material(
      color: whiteColor,
      child: Container(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              loading
                  ? SizedBox(
                      height: height * 0.04,
                    )
                  : Container(),
              loading
                  ? LinearProgressIndicator(
                      minHeight: height * 0.005,
                      backgroundColor: Colors.blue,
                      valueColor: AlwaysStoppedAnimation(
                        Colors.black,
                      ),
                    )
                  : Container(),
              SizedBox(
                height: height * 0.08,
              ),
              titleHeading(height, width, "Create your profile"),
              SizedBox(
                height: height * 0.05,
              ),
              imageheader(height, width),
              nameTextfiled(height, width),
              button(height, width),
            ]),
      ),
    );
  }
}
