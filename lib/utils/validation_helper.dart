import 'package:flutter/widgets.dart';
import 'package:evnttrackr/i18n/strings.g.dart';

class ValidationHelper {
  static String? validatePassword(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return t.errors.pleaseEnterAPassword;
    }
    if (value.length < 6) {
      return t.errors.passwordTooShort;
    }
    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$').hasMatch(value)) {
      return t.errors.passwordComplexity;
    }
    return null;
  }

  static String? validateConfirmPassword(BuildContext context, String? value, String password) {
    if (value == null || value.isEmpty) {
      return t.errors.pleaseConfirmYourPassword;
    }
    if (value != password) {
      return t.errors.passwordsDoNotMatch;
    }
    return null;
  }
}
