import 'package:flutter/material.dart';
import 'package:flutter_intelihub/helper/custom_button.dart';
import 'package:flutter_intelihub/layout/login_page.dart';
import 'package:flutter_intelihub/layout/registration_page.dart';
import 'package:flutter_intelihub/utils/app_color.dart';
import 'package:flutter_intelihub/utils/app_img.dart';
import 'package:flutter_intelihub/utils/app_string.dart';
import 'package:get/get.dart';

class OnGoingPage extends StatefulWidget {
  const OnGoingPage({Key? key}) : super(key: key);

  @override
  State<OnGoingPage> createState() => _OnGoingPageState();
}

class _OnGoingPageState extends State<OnGoingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              const Center(
                child: Text(
                  AppString.helloThere,
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 20),
              Image.asset(AppImage.rgImg, height: 400, fit: BoxFit.contain),
              const SizedBox(height: 30),
              CustomButton(onTap: (){Get.to(const LoginPage());},btnTag: AppString.login),
              const SizedBox(height: 30),
              CustomButton(onTap: (){Get.to(const RegistrationPage());},btnTag: AppString.registration)
            ],
          ),
        ),
      ),
    );
  }

}
