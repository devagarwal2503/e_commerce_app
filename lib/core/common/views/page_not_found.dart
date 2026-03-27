import 'package:e_commerce_app/core/common/views/main_dashboard_screen.dart';
import 'package:e_commerce_app/core/common/widgets/gradient_background.dart';
import 'package:e_commerce_app/core/extensions/context_extension.dart';
import 'package:e_commerce_app/core/resources/colors.dart';
import 'package:e_commerce_app/core/resources/media_resources.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PageNotFound extends StatelessWidget {
  const PageNotFound({super.key});

  static const routeName = '/page-not-found';

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: context.height * 0.1),
          Container(
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Lottie.asset(MediaResources.pageNotFoundFinal),
          ),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: CustomColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(10),
              ),
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(
                context,
                MainDashboardScreen.routeName,
              );
            },
            child: Text(
              context.localText.goToHomeText,
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
