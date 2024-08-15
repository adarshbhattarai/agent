import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/palette.dart';

class CustomTextField extends StatelessWidget {
  final String? placeholder;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool hideText;
  final TextEditingController? controller;
  final bool valid;
  final String? errorText;
  final bool isEmail;

  const CustomTextField(
      {Key? key,
        this.valid = true,
        this.errorText,
        this.suffixIcon,
        this.controller,
        this.hideText = false,
        this.placeholder,
        this.prefixIcon,
        this.isEmail=false, })
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextField(
        controller: controller,
        obscureText: hideText,
        keyboardType: isEmail? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
            errorText: valid ? null : errorText,
            suffixIcon: suffixIcon,
            contentPadding: EdgeInsets.all(10),
            errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: errorThemeColor),
                borderRadius: BorderRadius.all(Radius.circular(35))),
            focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: errorThemeColor),
                borderRadius: BorderRadius.all(Radius.circular(35))),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Palette.textColor1),
                borderRadius: BorderRadius.all(Radius.circular(35))),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(  color: Palette.textColor1, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(35))),
            disabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(35))),
            hintText: placeholder,
            hintStyle: TextStyle(fontSize: 14, color: Palette.textColor1),
            prefixIcon: prefixIcon),
      ),
    );
  }
}

//
// prefixIcon: Icon(
// icon,
// color: Palette.iconColor
// ),
