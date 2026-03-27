import 'package:e_commerce_app/core/common/app/provider/user_provider.dart';
import 'package:e_commerce_app/core/common/views/main_dashboard_screen.dart';
import 'package:e_commerce_app/core/extensions/context_extension.dart';
import 'package:e_commerce_app/core/resources/media_resources.dart';
import 'package:e_commerce_app/core/utils/core_utils.dart';
import 'package:e_commerce_app/src/authentication/data/models/user_model.dart';
import 'package:e_commerce_app/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:e_commerce_app/src/authentication/presentation/views/sign_up_screen.dart';
import 'package:e_commerce_app/src/authentication/presentation/widgets/sign_in_form.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const routeName = '/sign-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
      backgroundColor: context.appColors.scaffoldBg,
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationErrorState) {
            CoreUtils.showSnackBar(context, state.errorMessage, "");
          } else if (state is SignInSuccessState) {
            context.read<UserProvider>().initUser(state.user as LocalUserModel);
            Navigator.pushReplacementNamed(
              context,
              MainDashboardScreen.routeName,
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(20),
              children: [
                Text(
                  context.localText.welcomeBackText,
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w700,
                    color: context.appColors.primaryTextColor,
                  ),
                ),

                SizedBox(height: context.height * 0.04),
                SignInForm(
                  emailController: emailController,
                  passwordController: passwordController,
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
                              border: Border.all(
                                color: context.appColors.primary,
                              ),
                              color: Color(0XFFFCF3F6),
                            ),
                            padding: EdgeInsets.all(10),
                            child: Image.asset(MediaResources.googleLogo),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                color: context.appColors.primary,
                              ),
                              color: Color(0XFFFCF3F6),
                            ),
                            padding: EdgeInsets.all(10),
                            child: Image.asset(MediaResources.appleLogo),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                color: context.appColors.primary,
                              ),
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
                        text: "${context.localText.createAnAccountText} ",
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
                                  SignUpScreen.routeName,
                                );
                              },
                            text: context.localText.signUpText,
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
          );
        },
      ),
    );
  }
}
