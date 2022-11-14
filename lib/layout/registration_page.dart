import 'package:flutter/material.dart';
import 'package:flutter_intelihub/helper/custom_button.dart';
import 'package:flutter_intelihub/helper/text_from_fields_helper.dart';
import 'package:flutter_intelihub/layout/feed_page.dart';
import 'package:flutter_intelihub/utils/app_string.dart';
import 'package:flutter_intelihub/utils/app_utils.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

RegExp emailRegex = RegExp(
    r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final GeolocatorPlatform geolocatorPlatform = GeolocatorPlatform.instance;

  @override
  void initState() {
    handlePermission();
    super.initState();
  }

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 50),
                      const Center(
                        child: Text(
                          AppString.registration,
                          style: TextStyle(
                              fontSize: 32, fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(height: 50),
                      CustomTextFormField(
                          helperText: AppString.firstName,
                          controller: firstNameController,
                          validator: (val) {
                            if (val?.isEmpty ?? false) {
                              return AppString.firstNameFeildValidation;
                            } else if ((val?.length ?? 0) < 2) {
                              return AppString.firstNameLengthValidation;
                            }

                            return null;
                          }),
                      const SizedBox(height: 16),
                      CustomTextFormField(
                          helperText: AppString.lastName,
                          controller: lastNameController,
                          validator: (val) {
                            if (val?.isEmpty ?? false) {
                              return AppString.lastNameFeildValidation;
                            } else if ((val?.length ?? 0) < 2) {
                              return AppString.lastNameLengthValidation;
                            }

                            return null;
                          }),
                      const SizedBox(height: 16),
                      CustomTextFormField(
                          helperText: AppString.email,
                          controller: emailController,
                          validator: (val) {
                            if (val?.isEmpty ?? false) {
                              return AppString.emailFeildValidation;
                            } else if (!emailRegex
                                .hasMatch(val ?? '')) {
                              return AppString.emailLengthValidation;
                            }

                            return null;
                          }),
                      const SizedBox(height: 16),
                      CustomTextFormField(
                          helperText: AppString.password,
                          controller: passController,
                          validator: (val) {
                            if (val?.isEmpty ?? false) {
                              return AppString.passFeildValidation;
                            } else if ((val?.length ?? 0) < 6) {
                              return AppString.passLengthValidation;
                            }

                            return null;
                          }),
                    ],
                  ),
                  const SizedBox(height: 32),
                  CustomButton(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        final bool emailValid =
                            emailRegex.hasMatch(emailController.text.trim());
                        if (firstNameController.text.trim().length >= 2 &&
                            lastNameController.text.trim().length >= 2 &&
                            emailValid &&
                            passController.text.trim().length >= 6) {
                          Get.offAll(const FeedPage());
                        } else {
                          AppUtils.flutterShowToast(
                              msg: AppString.validateFields);
                        }
                      },
                      btnTag: AppString.registration),
                  const SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  Future<bool> handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      AppUtils.flutterShowToast(msg: "Location Services not enabled!!");
      return false;
    }

    permission = await geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        AppUtils.flutterShowToast(msg: AppString.kPermissionDeniedMessage);
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      AppUtils.flutterShowToast(msg: AppString.kPermissionDeniedForeverMessage);
      return false;
    }

    return true;
  }
}
