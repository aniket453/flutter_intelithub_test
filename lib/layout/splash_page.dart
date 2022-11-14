import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_intelihub/layout/ongoing_page.dart';
import 'package:flutter_intelihub/utils/app_color.dart';
import 'package:flutter_intelihub/utils/app_string.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin, AfterLayoutMixin {
  late Animation<double>  animation;
  late AnimationController animationController;

  @override
  void initState() {
    animationCall();
    super.initState();
  }

  animationCall(){
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animation = Tween<double>(begin: 0, end: -300).animate(animationController)
      ..addListener(() {
        setState(() {
          if(animationController.isCompleted){
            Future.delayed(const Duration(milliseconds: 700), () => Get.to(const OnGoingPage()));
          }
        });
      });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: Center(
            child: Align(
              alignment: const AlignmentDirectional(0,1),
              child: Transform.translate(
                offset: Offset(0, animation.value),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: const [
                    FlutterLogo(
                      size: 100,
                    ),
                    Text(AppString.appName),
                  ],
                ),
              ),
            )),
      ),
    );
  }


  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    animationController.forward();
  }
}
