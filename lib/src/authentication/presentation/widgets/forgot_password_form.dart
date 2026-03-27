import 'package:e_commerce_app/core/common/widgets/app_text_field.dart';
import 'package:e_commerce_app/core/extensions/context_extension.dart';
import 'package:e_commerce_app/src/authentication/presentation/views/sign_in_screen.dart';
import 'package:flutter/material.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({
    required this.emailController,
    required this.formKey,
    super.key,
  });

  final TextEditingController emailController;
  final GlobalKey<FormState> formKey;

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          AppTextField(
            controller: widget.emailController,
            hintText: context.localText.enterYourEmailAddressText,
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
          Align(
            alignment: AlignmentGeometry.centerStart,
            child: RichText(
              text: TextSpan(
                text: "* ",
                style: TextStyle(
                  color: context.appColors.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  TextSpan(
                    text: context.localText.forgotPasswordMsgText,
                    style: TextStyle(
                      color: context.appColors.primaryTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: context.height * 0.01),

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
              Navigator.pushNamedAndRemoveUntil(
                context,
                SignInScreen.routeName,
                (route) => false,
              );
            },
            child: Text(
              context.localText.submitText,
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
