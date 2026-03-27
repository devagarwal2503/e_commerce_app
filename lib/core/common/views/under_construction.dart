import 'package:e_commerce_app/core/common/widgets/gradient_background.dart';
import 'package:e_commerce_app/core/extensions/context_extension.dart';
import 'package:e_commerce_app/core/resources/media_resources.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PageUnderConstruction extends StatelessWidget {
  const PageUnderConstruction({required this.pageName, super.key});

  final String pageName;

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Lottie.asset(MediaResources.underConstruction),
          Text(
            "${pageName} ${context.localText.pageUnderConstructionText}",
            style: TextStyle(
              fontSize: 24,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          // ElevatedButton(
          //   style: ButtonStyle(
          //     backgroundColor: WidgetStateProperty.all(
          //       CustomColors.primaryColor,
          //     ),
          //     padding: WidgetStateProperty.all(
          //       const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          //     ),
          //   ),
          //   onPressed: () {},
          //   child: Text(
          //     "GO TO HOME",

          //     style: TextStyle(
          //       fontSize: 23,
          //       fontWeight: FontWeight.w600,
          //       color: Colors.white,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
