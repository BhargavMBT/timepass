import 'package:flutter/material.dart';
import 'package:timepass/Utils/textStyles.dart';

Widget titleHeading(
  double height,
  double width,
  String title,
) {
  return Container(
    alignment: Alignment.topLeft,
    margin: EdgeInsets.only(
      left: width * 0.055,
      top: height * 0.02,
      bottom: height * 0.01,
    ),
    child: Text(title, style: textStyle20black),
  );
}
