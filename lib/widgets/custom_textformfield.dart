import 'package:flutter/services.dart';

import '../constants.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
    {
      super.key,
      required this.validator,
      required this.onSaved,
      this.controller = TextEditingController,
      this.isObscure = false,
      required this.fontSize,
      required this.fontColor,
      this.hintTextSize = 12,
      this.hintText = '',
      this.fillColor = Colors.black12,
      required this.height,
      required this.width,
      this.keyboardType = TextInputType.text,
      this.maxLength = 200
    }
  );

  final validator;
  final onSaved;
  final controller;
  final isObscure;
  final fontSize;
  final fontColor;
  final double height, width;
  final hintTextSize;
  final hintText;
  final fillColor;
  TextInputType keyboardType;
  int maxLength;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onSaved: onSaved,
      controller: controller,
      obscureText: isObscure,
      keyboardType: keyboardType,
      inputFormatters: [
        LengthLimitingTextInputFormatter(maxLength),
      ],
      style: TextStyle(
        fontSize: fontSize,
        color: fontColor,
      ),
      decoration: InputDecoration(), //CONTINUATION !!!!!
    )
  }
}