import 'package:flutter/material.dart';

const Color pcolor = Color.fromRGBO(13, 11, 38, 1);
const Color prime = Colors.white;
const Color accent = Colors.black;

ThemeData light = ThemeData(
  fontFamily: "Poppins",
  primaryColor: prime,
  backgroundColor: prime,
  accentColor: accent,
  textTheme: TextTheme(
      headline5: TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w700,
    color: accent,
  )),
  appBarTheme: AppBarTheme(
    backgroundColor: prime,
    iconTheme: IconThemeData(
      color: accent,
    ),
  ),
);

ThemeData dark = ThemeData(
  fontFamily: "Poppins",
  primaryColor: Colors.black,
  backgroundColor: Colors.black,
  accentColor: Colors.white,
  textTheme: TextTheme(
      headline5: TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  )),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.black,
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
);

class Mytheme with ChangeNotifier {
  static bool _isdark = true;

  ThemeMode currentTheme() {
    return _isdark ? ThemeMode.dark : ThemeMode.light;
  }

  void SwitchTheme() {
    _isdark = !_isdark;
    notifyListeners();
  }
}

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

List<Color> receiverGradient = [
  Color.fromRGBO(226, 134, 14, 1),
  Color.fromRGBO(255, 179, 79, 1),
  Color.fromRGBO(255, 179, 79, 1),
];

List<Color> senderGradient = [
  Color.fromRGBO(38, 203, 255, 1),
  Color.fromRGBO(105, 128, 253, 1),
];
