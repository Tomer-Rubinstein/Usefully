import 'package:flutter/material.dart';

class Styles {
  static LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.1, 0.4, 0.7, 0.9],
    colors: [
      Color(0xFF3594DD),
      Color(0xFF4563DB),
      Color(0xFF5036D5),
      Color(0xFF5B16D0),
    ],
  );

  static TextStyle title = TextStyle(
    color: Colors.white,
    fontSize: 48,
    fontFamily: "RobotoMono",
    letterSpacing: .6
  );

  static TextStyle content = TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontFamily: "RobotoMono",
  );
}
