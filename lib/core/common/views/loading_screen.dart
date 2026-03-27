import 'package:e_commerce_app/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          context.theme.colorScheme.secondary,
        ),
      ),
    );
  }
}
