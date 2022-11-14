import 'package:flutter/material.dart';
import 'package:flutter_intelihub/helper/custom_button.dart';
import 'package:flutter_intelihub/helper/text_from_feilds_helper.dart';
import 'package:flutter_intelihub/layout/feed_page.dart';
import 'package:flutter_intelihub/utils/app_string.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    TextFormFeildsHelper(
                        helperText: AppString.name,
                        controller: nameController,
                        validator: (val) {
                          if (val?.isEmpty ?? false) {
                            return AppString.nameFeildValidation;
                          } else if ((val?.length ?? 0) < 2) {
                            return AppString.nameLengthValidation;
                          }

                          return null;
                        }),
                    const SizedBox(height: 16),
                    TextFormFeildsHelper(
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
                CustomButton(onTap: () {
                  if ((nameController.value != null ||
                      nameController.text.length > 2) &&
                      (passController.value != null ||
                          passController.text.length > 6)){
                    Get.to(FeedPage());
                  }
                }, btnTag: AppString.login)
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    passController.dispose();
    super.dispose();
  }
}
