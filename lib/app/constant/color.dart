import 'package:flutter/material.dart';

const appPurple = Color(0xFF6F35A5);
const appWhite = Color(0xFFFAF8FC);
const appLightPurple1 = Color(0xFF9345F2);
const appLightGrey = Color(0xFFB9A2D8);
const appOrange = Color(0xFFE6704A);

const appDarkPurple = Color(0xFF010313);

ThemeData appLight = ThemeData(
  primaryColor: appPurple,
  scaffoldBackgroundColor: appWhite,
  appBarTheme: AppBarTheme(
    backgroundColor: appPurple,
    foregroundColor: appWhite,
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: appPurple),
    headlineLarge: TextStyle(color: appPurple),
    bodyMedium: TextStyle(color: Colors.grey[500]),
  ),
);

ThemeData appDark = ThemeData(
  primaryColor: appWhite,
  scaffoldBackgroundColor: appDarkPurple,
  appBarTheme: AppBarTheme(
    backgroundColor: appDarkPurple,
    foregroundColor: appWhite,
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: appWhite),
    headlineLarge: TextStyle(color: appWhite),
    headlineSmall: TextStyle(color: Colors.grey[600]),
    bodyMedium: TextStyle(color: appWhite),
    bodySmall: TextStyle(color: Colors.grey[600]),
  ),
);
