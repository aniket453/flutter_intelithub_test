import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_intelihub/layout/feed_page.dart';
import 'package:flutter_intelihub/layout/ongoing_page.dart';
import 'package:flutter_intelihub/utils/app_color.dart';
import 'package:flutter_intelihub/utils/app_string.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  Animation<double>? animation;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();

    runSplashAnimation();
  }

  void runSplashAnimation() async {
    debugPrint('runSplashAnimation called 0');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool(AppString.isLoggedIn) ?? false;

    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animation = Tween<double>(begin: 0, end: -300).animate(animationController)
      ..addListener(() {
        debugPrint('runSplashAnimation called');
        setState(() {});

        if (animationController.isCompleted) {
          if (isLoggedIn) {
            Future.delayed(const Duration(milliseconds: 700),
                () => Get.off(const FeedPage()));
          } else {
            Future.delayed(const Duration(milliseconds: 700),
                () => Get.off(const OnGoingPage()));
          }
        }
      });
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: Center(
          child: Align(
            alignment: const AlignmentDirectional(0, 1),
            child: Transform.translate(
              offset: Offset(0, animation?.value ?? 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: const [
                  FlutterLogo(size: 100),
                  Text(AppString.appName),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
