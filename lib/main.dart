import 'package:beams_gas_cylinder/views/components/common/strings/commonStrings.dart';
import 'package:beams_gas_cylinder/views/screens/splashscreen/splash_screen.dart';
import 'package:beams_gas_cylinder/views/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: Appstrings.appName,
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context).copyWith(
        colorScheme: Theme.of(context).colorScheme.copyWith(
          primary: primaryColor,
          secondary: bgColor,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
