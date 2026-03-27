import 'package:e_commerce_app/core/extensions/context_extension.dart';
import 'package:e_commerce_app/core/resources/colors.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    this.validator,
    this.controller,
    this.filled = false,
    this.fillColor,
    this.obscureText = false,
    this.readOnly = false,
    this.suffixIcon,
    this.prefixIcon,
    this.hintText,
    this.textInputType,
    this.overrideValidator = false,
    this.onChanged,
    this.hintStyle,
    super.key,
  });

  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool filled;
  final Color? fillColor;
  final bool obscureText;
  final bool readOnly;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? hintText;
  final TextInputType? textInputType;
  final bool overrideValidator;
  final TextStyle? hintStyle;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      controller: controller,
      validator: overrideValidator
          ? validator
          : (value) {
              if (value == null || value.isEmpty) {
                return context.localText.thisFieldIsRequiredText;
              }
              return validator?.call(value);
            },
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      keyboardType: textInputType,
      obscureText: obscureText,
      readOnly: readOnly,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: CustomColors.primaryColor),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        filled: filled,
        fillColor: fillColor,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle:
            hintStyle ?? TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      ),
    );
  }
}
