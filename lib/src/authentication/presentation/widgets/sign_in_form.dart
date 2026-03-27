import 'package:e_commerce_app/core/common/views/main_dashboard_screen.dart';
import 'package:e_commerce_app/core/common/widgets/app_text_field.dart';
import 'package:e_commerce_app/core/extensions/context_extension.dart';
import 'package:e_commerce_app/src/authentication/presentation/views/forgot_password_screen.dart';
import 'package:flutter/material.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    required this.emailController,
    required this.passwordController,
    required this.formKey,
    super.key,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          AppTextField(
            controller: widget.emailController,
            hintText: context.localText.usernameOrEmailText,
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
          SizedBox(height: context.height * 0.04),
          AppTextField(
            controller: widget.passwordController,
            hintText: context.localText.passwordText,
            hintStyle: TextStyle(
              color: context.appColors.formFillTextColor,
              fontSize: 14,
            ),
            prefixIcon: Icon(
              Icons.lock,
              color: context.appColors.formFillTextColor,
            ),
            obscureText: obscurePassword,
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
          SizedBox(height: context.height * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, ForgotPasswordScreen.routeName);
                },
                child: Text(
                  context.localText.forgotPasswordText,
                  style: TextStyle(
                    color: context.appColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
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
              Navigator.pushReplacementNamed(
                context,
                MainDashboardScreen.routeName,
              );
            },
            child: Text(
              context.localText.loginText,
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
