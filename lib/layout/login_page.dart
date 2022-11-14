import 'package:flutter/material.dart';
import 'package:flutter_intelihub/helper/custom_button.dart';
import 'package:flutter_intelihub/helper/text_from_fields_helper.dart';
import 'package:flutter_intelihub/layout/feed_page.dart';
import 'package:flutter_intelihub/utils/app_string.dart';
import 'package:flutter_intelihub/utils/app_utils.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool value = false;

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
                    CustomTextFormField(
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
                    Row(
                      children: [
                        SizedBox(
                          height: 24,
                          width: 24,
                          child: Checkbox(
                            value: value,
                            onChanged: (bool? value) {
                              setState(() {
                                this.value = value!;
                              });
                            },
                          ),
                        ),
                        const Text('remember me'),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                CustomButton(
                    onTap: () async {
                      FocusScope.of(context).unfocus();

                      if (nameController.text.trim().length >= 2 &&
                          passController.text.trim().length >= 6) {
                        if (value) {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.setBool(AppString.isLoggedIn, true);
                        }

                        Get.offAll(const FeedPage());
                      } else {
                        AppUtils.flutterShowToast(
                            msg: AppString.validateFields);
                      }
                    },
                    btnTag: AppString.login)
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
