import 'package:e_commerce_app/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  const GradientBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          transform: GradientRotation(75),
          colors: context.appColors.mainGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),

      child: SafeArea(child: child),
    );
  }
}
