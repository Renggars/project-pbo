import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'package:aplikasi_alquran/app/constant/color.dart';

void main() {
  runApp(
    GetMaterialApp(
      theme: appLight,
      title: "Application",
      // initialRoute: Routes.INTRODUCTION,
      initialRoute: Routes.HOME,
      getPages: AppPages.routes,
    ),
  );
}
