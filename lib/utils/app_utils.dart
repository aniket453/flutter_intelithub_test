import 'package:flutter/material.dart';
import 'package:flutter_intelihub/utils/app_color.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppUtils {
  static void flutterShowToast({required String msg}) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: AppColor.primary,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
