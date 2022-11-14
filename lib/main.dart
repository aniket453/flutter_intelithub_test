import 'package:flutter/material.dart';
import 'package:flutter_intelihub/layout/ongoing_page.dart';
import 'package:flutter_intelihub/layout/registration_page.dart';
import 'package:flutter_intelihub/layout/splash_page.dart';
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
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/splash',
      defaultTransition: Transition.native,
      getPages: [
        //Simple GetPage
        GetPage(name: '/splash', page: () => const SplashPage()),
        GetPage(name: '/onGoing', page: () => const OnGoingPage()),
        GetPage(name: '/home', page: () => const RegistrationPage())
      ],
    );
  }
}
