// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:e_commerce_app/core/common/views/main_dashboard_screen.dart';
import 'package:e_commerce_app/core/common/widgets/modern_toast.dart';
import 'package:e_commerce_app/core/extensions/context_extension.dart';
import 'package:e_commerce_app/core/resources/media_resources.dart';
import 'package:e_commerce_app/src/authentication/presentation/views/sign_up_screen.dart';
import 'package:e_commerce_app/src/authentication/presentation/widgets/sign_in_form.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

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

  final LocalAuthentication auth = LocalAuthentication();
  bool biometricAvailable = false;

  @override
  void initState() {
    super.initState();
    _checkBiometricAvailable();
  }

  void _checkBiometricAvailable() async {
    try {
      bool available = await auth.canCheckBiometrics;
      setState(() {
        biometricAvailable = available;
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime? _lastPressedAt;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        // 2. If on Home, handle the "Double Swipe" logic
        final now = DateTime.now();
        final backButtonHasNotBeenPressedRecently =
            _lastPressedAt == null ||
            now.difference(_lastPressedAt!) > const Duration(seconds: 2);

        if (backButtonHasNotBeenPressedRecently) {
          _lastPressedAt = now;
          showModernToast(
            context,
            context.localText.swipeAgainToExitText,
            const Color(0xFF323232),
          );

          return;
        }
        SystemNavigator.pop(animated: true);
      },
      child: Scaffold(
        backgroundColor: context.appColors.scaffoldBg,
        body: SafeArea(
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
                    width: context.width * 0.6,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: _biometricAuth,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                color: context.appColors.primary,
                              ),
                              color: Color(0XFFFCF3F6),
                            ),
                            padding: EdgeInsets.all(10),
                            child: Icon(
                              Icons.fingerprint,
                              color: context.appColors.primary,
                            ),
                          ),
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
        ),
        // body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        //   listener: (context, state) {
        //     if (state is AuthenticationErrorState) {
        //       CoreUtils.showSnackBar(context, state.errorMessage, "");
        //     } else if (state is SignInSuccessState) {
        //       context.read<UserProvider>().initUser(
        //         state.user as LocalUserModel,
        //       );
        //       Navigator.pushReplacementNamed(
        //         context,
        //         MainDashboardScreen.routeName,
        //       );
        //     }
        //   },
        //   builder: (context, state) {

        //   },
        // ),
      ),
    );
  }

  _biometricAuth() async {
    if (!biometricAvailable) {
      return;
    }

    try {
      emailController.clear();
      passwordController.clear();
      bool authResult = await auth.authenticate(
        localizedReason: "Scan For Logging In !!",
        // persistAcrossBackgrounding: true,
      );

      if (authResult) {
        // Handle successful authentication
        if (mounted) {
          showModernToast(context, "Logged In", context.appColors.primary);
          Navigator.pushReplacementNamed(
            context,
            MainDashboardScreen.routeName,
          );
        }
      }
    } catch (e) {
      if (mounted) {
        showModernToast(
          context,
          "User Not Found !!!",
          context.appColors.primary,
        );
      }
      throw Exception(e);
    }
  }
}
