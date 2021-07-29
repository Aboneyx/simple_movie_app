import 'package:flutter/material.dart';

showCustomSnackBar({required BuildContext context, required String message}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 6.0,
      behavior: SnackBarBehavior.floating,
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.red,
    ),
  );
}

