import 'package:e_commerce_app/core/extensions/context_extension.dart';
import 'package:e_commerce_app/core/utils/core_utils.dart';
import 'package:e_commerce_app/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:e_commerce_app/src/authentication/presentation/widgets/forgot_password_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  static const routeName = '/forgot-password-screen';

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationErrorState) {
            CoreUtils.showSnackBar(context, state.errorMessage, "");
          } else if (state is ForgotPasswordSentState) {
            // Navigator.pushReplacementNamed(
            //   context,
            //   MainDashboardScreen.routeName,
            // );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(20),
              children: [
                Text(
                  context.localText.forgotPasswordText,

                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w700,
                    height: 1,
                    color: context.appColors.primaryTextColor,
                  ),
                ),

                SizedBox(height: context.height * 0.04),
                ForgotPasswordForm(
                  emailController: emailController,
                  formKey: formKey,
                ),
                SizedBox(height: context.height * 0.04),
              ],
            ),
          );
        },
      ),
    );
  }
}
