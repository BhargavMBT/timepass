import 'package:flutter/material.dart';

const Color pcolor = Color.fromRGBO(13, 11, 38, 1);
const Color whiteColor = Colors.white;
const Color blackColor = Colors.black;

ThemeData themeData = ThemeData(
  fontFamily: "Poppins",
  primaryColor: whiteColor,
  backgroundColor: whiteColor,
  accentColor: blackColor,
  textTheme: TextTheme(
      headline5: TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w700,
    color: blackColor,
  )),
  appBarTheme: AppBarTheme(
    backgroundColor: whiteColor,
    iconTheme: IconThemeData(
      color: blackColor,
    ),
  ),
);

LinearGradient storyGradient = LinearGradient(colors: [
  Color.fromRGBO(38, 203, 255, 1),
  Color.fromRGBO(38, 203, 255, 1),
  Color.fromRGBO(105, 128, 253, 1),
  Color.fromRGBO(105, 128, 253, 1),
]);

LinearGradient profileCategoryGradient = LinearGradient(colors: [
  Color.fromRGBO(38, 203, 255, 1),
  Color.fromRGBO(105, 128, 253, 0.5),
]);
