import 'dart:async';

import 'package:e_commerce_app/core/extensions/context_extension.dart';
import 'package:e_commerce_app/core/resources/media_resources.dart';
import 'package:e_commerce_app/core/services/injection_container.dart';
import 'package:e_commerce_app/src/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const routeName = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    final sharedPreference = sl<SharedPreferences>();

    Timer(const Duration(seconds: 5), () {
      if (sharedPreference.getBool(kFirstTimerKey) ?? true) {
        Navigator.pushReplacementNamed(context, '/on-boarding');
      }
      // else if (sl<FirebaseAuth>().currentUser != null) {
      //   final user = sl<FirebaseAuth>().currentUser;
      //   final localUser = LocalUserModel(
      //     uid: user!.uid,
      //     email: user.email ?? "",
      //     fullName: user.displayName ?? "",
      //   );
      //   context.userProvider.initUser(localUser);
      //   Navigator.pushReplacementNamed(context, '/main-screen', arguments: 0);
      // }
      else {
        Navigator.pushReplacementNamed(context, '/sign-in');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            transform: GradientRotation(75),
            colors: context.appColors.mainGradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(MediaResources.logoWithName),
              SizedBox(height: 20),

              Lottie.asset(MediaResources.loadingAnimation),
            ],
          ),
        ),
      ),
    );
  }
}
