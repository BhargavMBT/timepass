import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:timepass/API/APIservices.dart';
import 'package:timepass/Screens/profile_Screen.dart';
import 'package:timepass/Widgets/animationWidget.dart';
import 'package:timepass/Widgets/moreWidget.dart';
import 'package:timepass/models/profileModel.dart';

class BackAerrowWidget extends StatelessWidget {
  Widget leadingIcon(double height, double width) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(
        left: width * 0.01,
      ),
      height: height * 0.08,
      width: width * 0.09,
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 1),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(
              0,
              0,
              0,
              0.25,
            ),
            blurRadius: 14,
            spreadRadius: 0,
            offset: Offset(6, 6),
          )
        ],
        shape: BoxShape.circle,
      ),
      child: Align(
        alignment: Alignment.center,
        child: Icon(
          Icons.arrow_back_ios,
          size: 13,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return leadingIcon(height, width);
  }
}

AppBar appbarOfHOmepage(double height, double width, BuildContext context) {
  return AppBar(
    leading: GestureDetector(
      onTap: () {
        navagtionRoute(
          context,
          MoreWidget(),
        );
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (BuildContext context) {
        //   return RoundTransition(
        //     widget: MoreWidget(),
        //   );
        // }));
      },
      child: Container(
          margin: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.01,
            top: MediaQuery.of(context).size.height * 0.02,
            bottom: MediaQuery.of(context).size.height * 0.01,
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue,
          ),
          height: MediaQuery.of(context).size.height * 0.01,
          width: MediaQuery.of(context).size.width * 0.01,
          child: Image(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.02,
            image: AssetImage(
              "Assets/Images/leadingIcon.png",
            ),
          )),
    ),
    actions: [
      profileIcon(context),
    ],
    elevation: 0,
    title: Container(
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.011,
      ),
      height: MediaQuery.of(context).size.height * 0.08,
      width: MediaQuery.of(context).size.width * 0.15,
      child: Image.asset(
        "Assets/Images/socioClub2x.png",
        fit: BoxFit.fill,
      ),
    ),
    centerTitle: true,
    backgroundColor: Colors.white,
  );
}

Widget profileIcon(BuildContext context) {
  return GestureDetector(
    onTap: () {
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (BuildContext context) {
      //   return ProfileScreen();
      // }));
      navagtionRoute(
        context,
        ProfileScreen(),
      );
    },
    child: FutureBuilder(
      future: APIServices().getProfile(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          var jsonData = jsonDecode(snapshot.data);
          UserProfile user = UserProfile.fromJson(jsonData);
          return Container(
            margin: EdgeInsets.only(
              right: MediaQuery.of(context).size.width * 0.02,
            ),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                    user.imageurl!,
                  ),
                )),
            height: MediaQuery.of(context).size.height * 0.07,
            width: MediaQuery.of(context).size.width * 0.08,
          );
        } else if (snapshot.hasError) {
          return Container(
              margin: EdgeInsets.only(
                right: MediaQuery.of(context).size.width * 0.02,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width * 0.07,
              child: Icon(Icons.error));
        } else {
          return Container();
        }
      },
    ),
  );
}
