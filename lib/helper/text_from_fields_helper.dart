import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String? value)? validator;
  final String? helperText;
  final ValueChanged<String>? onChanged;
  final InputDecoration? inputDecoration;

  const CustomTextFormField(
      {required this.controller,
      this.validator,
      this.onChanged,
      this.inputDecoration,
      this.helperText,
      Key? key})
      : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: TextFormField(
        onChanged: widget.onChanged,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: widget.validator,
        controller: widget.controller,
        decoration: widget.inputDecoration ??
            InputDecoration(
                hintText: widget.helperText ?? "",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20))),
      ),
    );
  }
}
