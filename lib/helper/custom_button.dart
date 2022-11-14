import 'package:flutter/material.dart';
import 'package:flutter_intelihub/utils/app_color.dart';

class CustomButton extends StatelessWidget {
  final String? btnTag;
  final VoidCallback? onTap;
  final Color? color;

  const CustomButton({this.btnTag, this.onTap, this.color, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
                color: color ?? AppColor.primary,
                borderRadius: const BorderRadius.all(Radius.circular(12))),
            child: Text(
              btnTag!,
              style: TextStyle(fontSize: 16, color: AppColor.white),
            )));
  }
}
