import 'package:e_commerce_app/core/resources/colors.dart';
import 'package:flutter/material.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({
    required this.controller,
    this.onChanged,
    this.onSubmitted,
    this.hintText = 'Search any Product...',
    this.fillColor = Colors.white,
    this.filled = true,
    this.prefixIcon,
    this.suffixIcon,
    this.hintStyle,
    this.textInputType = TextInputType.text,
    super.key,
  });

  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final String? hintText;
  final bool filled;
  final Color? fillColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextStyle? hintStyle;
  final TextInputType? textInputType;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextFormField(
          controller: controller,
          onChanged: onChanged,
          onFieldSubmitted: onSubmitted,
          keyboardType: textInputType,
          textInputAction: TextInputAction.search,
          onTapOutside: (event) {
            FocusScope.of(context).unfocus();
          },
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle:
                hintStyle ??
                const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: CustomColors.searchFillTextColor,
                ),
            prefixIcon:
                prefixIcon ??
                const Icon(
                  Icons.search,
                  color: CustomColors.searchFillTextColor,
                ),
            suffixIcon:
                suffixIcon ??
                const Icon(
                  Icons.keyboard_voice_outlined,
                  color: CustomColors.searchFillTextColor,
                ),
            filled: filled,
            fillColor: fillColor,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 1,
            ),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.transparent,
                width: 1.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
