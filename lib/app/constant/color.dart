import 'package:flutter/material.dart';

const greenPrimary = Color(0xFF13A795);
const appWhite = Color(0xFFFAF8FC);
const appLightPurple1 = Color(0xFF9345F2);
const appLightGrey = Color(0xFFB9A2D8);
const appOrange = Color(0xFFE6704A);

const appDarkPurple = Color(0xFF010313);

ThemeData appLight = ThemeData(
    primaryColor: greenPrimary,
    scaffoldBackgroundColor: appWhite,
    appBarTheme: AppBarTheme(
      backgroundColor: greenPrimary,
      foregroundColor: appWhite,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      headlineLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black),
      bodySmall: TextStyle(color: greenPrimary),
    ),
    tabBarTheme: TabBarTheme(
      labelColor: greenPrimary,
      unselectedLabelColor: Colors.grey[500],
    ));
