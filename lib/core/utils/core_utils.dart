import 'package:flutter/material.dart';

class CoreUtils {
  const CoreUtils._();

  static void showSnackBar(BuildContext context, String message, String type) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.all(10),
        ),
      );
  }
}
