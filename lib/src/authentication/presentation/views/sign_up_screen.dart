import 'package:e_commerce_app/core/extensions/context_extension.dart';
import 'package:e_commerce_app/core/resources/media_resources.dart';
import 'package:e_commerce_app/src/authentication/presentation/views/sign_in_screen.dart';
import 'package:e_commerce_app/src/authentication/presentation/widgets/sign_up_form.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const routeName = '/sign-up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(20),
          children: [
            Text(
              context.localText.createAnAccountText,
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.w700,
                height: 1.1,
                color: context.appColors.primaryTextColor,
              ),
            ),

            SizedBox(height: context.height * 0.04),
            SignUpForm(
              nameController: nameController,
              emailController: emailController,
              passwordController: passwordController,
              confirmPasswordController: confirmPasswordController,
              formKey: formKey,
            ),
            SizedBox(height: context.height * 0.04),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "- ${context.localText.continueWithText} -",
                  style: TextStyle(
                    color: context.appColors.primaryTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: context.height * 0.02),
                SizedBox(
                  width: context.width * 0.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: context.appColors.primary),
                          color: Color(0XFFFCF3F6),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Image.asset(MediaResources.googleLogo),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: context.appColors.primary),
                          color: Color(0XFFFCF3F6),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Image.asset(MediaResources.appleLogo),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: context.appColors.primary),
                          color: Color(0XFFFCF3F6),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Image.asset(MediaResources.facebookLogo),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: context.height * 0.04),
                RichText(
                  text: TextSpan(
                    text: "${context.localText.alreadyHaveAnAccountText} ",
                    style: TextStyle(
                      color: context.appColors.primaryTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacementNamed(
                              context,
                              SignInScreen.routeName,
                            );
                          },
                        text: context.localText.loginText,
                        style: TextStyle(
                          color: context.appColors.primary,
                          decoration: TextDecoration.underline,
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      // body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
      //   listener: (context, state) {
      //     if (state is AuthenticationErrorState) {
      //       CoreUtils.showSnackBar(context, state.errorMessage, "");
      //     } else if (state is SignUpSuccessState) {
      //       Navigator.pushReplacementNamed(
      //         context,
      //         MainDashboardScreen.routeName,
      //       );
      //     }
      //   },
      //   builder: (context, state) {
      //     return
      //   },
      // ),
    );
  }
}
