import 'package:eminencetel/features/presentation/res/locale_strings.dart';

class TextUtils {
  static bool isEmailValid(String email) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(p);
    return regExp.hasMatch(email);
  }

  static String? validateEmail(String email) {
    if (email.isEmpty) {
      return LocaleStrings.login_screen_input_email_error_empty;
    } else if (!TextUtils.isEmailValid(email)) {
      return LocaleStrings.login_screen_input_email_invalid_error;
    }
    return null;
  }

  static String? validatePassword(String password) {
    if (password.isEmpty) {
      return LocaleStrings.login_screen_input_password_error_empty;
    } else if (!(password.length > 5) && password.isNotEmpty) {
      return "Password should contain more than 5 characters";
    }
    return null;
  }

  static String? emptyValidation(String value) {
    if (value.isEmpty) {
      return 'Field can\'t empty';
    }
    return null;
  }
}
