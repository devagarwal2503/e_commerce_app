import 'package:e_commerce_app/core/common/widgets/app_text_field.dart';
import 'package:e_commerce_app/core/extensions/context_extension.dart';
import 'package:e_commerce_app/core/common/views/main_dashboard_screen.dart';
import 'package:e_commerce_app/src/authentication/presentation/views/sign_in_screen.dart';
import 'package:flutter/material.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.formKey,
    super.key,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final GlobalKey<FormState> formKey;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          AppTextField(
            controller: widget.nameController,
            hintText: context.localText.enterYourNameText,
            hintStyle: TextStyle(
              color: context.appColors.formFillTextColor,
              fontSize: 14,
            ),
            prefixIcon: Icon(
              Icons.person,
              color: context.appColors.formFillTextColor,
            ),
            fillColor: context.appColors.formFieldFillColor,
            filled: true,
          ),
          SizedBox(height: context.height * 0.03),
          AppTextField(
            controller: widget.emailController,
            hintText: context.localText.usernameOrEmailText,
            hintStyle: TextStyle(
              color: context.appColors.formFillTextColor,
              fontSize: 14,
            ),
            prefixIcon: Icon(
              Icons.mail,
              color: context.appColors.formFillTextColor,
            ),
            fillColor: context.appColors.formFieldFillColor,
            filled: true,
          ),
          SizedBox(height: context.height * 0.03),
          AppTextField(
            controller: widget.passwordController,
            hintText: context.localText.passwordText,
            obscureText: obscurePassword,
            hintStyle: TextStyle(
              color: context.appColors.formFillTextColor,
              fontSize: 14,
            ),
            prefixIcon: Icon(
              Icons.lock,
              color: context.appColors.formFillTextColor,
            ),
            suffixIcon: InkWell(
              onTap: () {
                setState(() {
                  obscurePassword = !obscurePassword;
                });
              },
              child: Icon(
                obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: context.appColors.formFillTextColor,
              ),
            ),
            fillColor: context.appColors.formFieldFillColor,
            filled: true,
          ),
          SizedBox(height: context.height * 0.03),
          AppTextField(
            controller: widget.confirmPasswordController,
            hintText: context.localText.confirmPasswordText,
            obscureText: obscureConfirmPassword,
            hintStyle: TextStyle(
              color: context.appColors.formFillTextColor,
              fontSize: 14,
            ),
            prefixIcon: Icon(
              Icons.lock,
              color: context.appColors.formFillTextColor,
            ),
            suffixIcon: InkWell(
              onTap: () {
                setState(() {
                  obscureConfirmPassword = !obscureConfirmPassword;
                });
              },
              child: Icon(
                obscureConfirmPassword
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: context.appColors.formFillTextColor,
              ),
            ),
            fillColor: context.appColors.formFieldFillColor,
            filled: true,
          ),
          SizedBox(height: context.height * 0.02),
          Align(
            alignment: AlignmentGeometry.centerStart,
            child: RichText(
              text: TextSpan(
                text: "${context.localText.byClickingTheText} ",
                style: TextStyle(
                  color: context.appColors.primaryTextColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                children: [
                  TextSpan(
                    text: context.localText.registerText,
                    style: TextStyle(
                      color: context.appColors.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(text: " ${context.localText.youAgreeToOfferText}"),
                ],
              ),
            ),
          ),
          SizedBox(height: context.height * 0.04),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0.0,
              fixedSize: Size(context.width * 0.9, context.height * 0.07),
              backgroundColor: context.appColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(5),
              ),
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, SignInScreen.routeName);
            },
            child: Text(
              context.localText.createAccountText,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
