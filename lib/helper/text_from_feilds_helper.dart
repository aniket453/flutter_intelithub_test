import 'package:flutter/material.dart';
import 'package:flutter_intelihub/utils/app_string.dart';

class TextFormFeildsHelper extends StatefulWidget {
  TextEditingController controller;
  String? Function(String? value) validator;
  String? helperText;
  InputDecoration? inputdecoration;
  TextFormFeildsHelper({required this.controller,required this.validator, this.inputdecoration,this.helperText,Key? key}) : super(key: key);

  @override
  State<TextFormFeildsHelper> createState() => _TextFormFeildsHelperState();
}

class _TextFormFeildsHelperState extends State<TextFormFeildsHelper> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator:widget.validator,
        controller: widget.controller,
        decoration: widget.inputdecoration ?? InputDecoration(hintText: widget.helperText?? "",border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      ),
    );
  }
}
