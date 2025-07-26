import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  void navigateToScreen({required Widget screen, bool isReplace = false}) {
    if (isReplace) {
      Navigator.pushAndRemoveUntil(
        this,
        MaterialPageRoute(builder: (_) => screen),
        (route) => false,
      );
    } else {
      Navigator.push(this, MaterialPageRoute(builder: (context) => screen));
    }
  }

  void hideKeyboard() {
    final currentFocus = FocusScope.of(this);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  double getHeight(double percent) => MediaQuery.of(this).size.height * percent;
  double getWidth(double percent) => MediaQuery.of(this).size.width * percent;
}
