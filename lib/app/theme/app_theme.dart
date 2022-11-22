import 'package:flutter/material.dart';

final ThemeData appThemeData = ThemeData(
  appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0),
  scaffoldBackgroundColor: Colors.white,
  indicatorColor: Colors.black,
  inputDecorationTheme: const InputDecorationTheme(
      floatingLabelStyle: TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  )),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
  ),
);
