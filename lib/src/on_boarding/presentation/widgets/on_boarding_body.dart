import 'package:e_commerce_app/core/extensions/context_extension.dart';
import 'package:e_commerce_app/src/on_boarding/domain/entities/page_content.dart';
import 'package:flutter/material.dart';

class OnBoardingBody extends StatelessWidget {
  const OnBoardingBody({required this.pageContent, super.key});

  final PageContent pageContent;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: context.height * 0.1),
        Image.asset(pageContent.image, height: context.height * 0.4),
        // SizedBox(height: context.height * 0.01),
        Padding(
          padding: EdgeInsetsGeometry.all(20),
          child: Column(
            children: [
              Text(
                pageContent.title,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
              ),

              SizedBox(height: context.height * 0.02),
              Text(
                pageContent.description,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
