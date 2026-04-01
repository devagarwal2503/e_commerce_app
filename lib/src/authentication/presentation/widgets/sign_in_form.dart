import 'package:e_commerce_app/core/common/views/main_dashboard_screen.dart';
import 'package:e_commerce_app/core/common/widgets/app_text_field.dart';
import 'package:e_commerce_app/core/common/widgets/modern_toast.dart';
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
            overrideValidator: true,
            validator: (value) {
              const pattern =
                  r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
                  r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
                  r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
                  r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
                  r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
                  r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
                  r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
              final regex = RegExp(pattern);

              if (value == null || !regex.hasMatch(value)) {
                return 'Enter a valid email address';
              } else {
                return null;
              }
            },
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
            overrideValidator: true,
            validator: (value) {
              const pattern =
                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
              final regex = RegExp(pattern);
              if (value == null || value.isEmpty) {
                return 'Password is required';
              } else if (!regex.hasMatch(value)) {
                return 'Password must meet the required criteria.';
              }
              return null;
            },
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
              if (widget.formKey.currentState!.validate()) {
                if (widget.emailController.text == "test@gmail.com" &&
                    widget.passwordController.text == "Password@123") {
                  showModernToast(
                    context,
                    "Logged In",
                    context.appColors.primary,
                  );
                  Navigator.pushReplacementNamed(
                    context,
                    MainDashboardScreen.routeName,
                  );
                } else {
                  showModernToast(
                    context,
                    "User Not Found !!!",
                    context.appColors.primary,
                  );
                }
              }
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
