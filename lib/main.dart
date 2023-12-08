import 'package:budget_tracker_app_af_6/Views/Screens/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(useMaterial3: true),
    getPages: [
      GetPage(
        name: '/',
        page: () => Home_Screen(),
      ),
    ],
  ));
}
