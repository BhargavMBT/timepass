import 'package:flutter/material.dart';

LinearProgressIndicator linearProgressIndicator(double height) =>
    LinearProgressIndicator(
      minHeight: height * 0.005,
      backgroundColor: Colors.blue,
      valueColor: AlwaysStoppedAnimation(
        Colors.black,
      ),
    );
CircularProgressIndicator circularProgressIndicator() =>
    CircularProgressIndicator(
      backgroundColor: Colors.blue,
      strokeWidth: 2,
      valueColor: AlwaysStoppedAnimation(
        Colors.black,
      ),
    );
