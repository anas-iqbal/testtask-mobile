import 'package:flutter/material.dart';

class AppTheme {
  static var primarySwatchColor =
      MaterialColor(const Color(0xff151646).value, const <int, Color>{
    50: Color(0xff151646),
    100: Color(0xff151646),
    200: Color(0xff151646),
    300: Color(0xff151646),
    400: Color(0xff151646),
    500: Color(0xff151646),
    600: Color(0xff151646),
    700: Color(0xff151646),
    800: Color(0xff151646),
    900: Color(0xff151646),
  });
}

class APIConstants {
  static String baseURL =
      "https://lb7u7svcm5.execute-api.ap-southeast-1.amazonaws.com/dev/";
  static String getClinicsAPI = "${baseURL}ingredients";
}

class ImageConstants {
  static String circadiaLogo = 'assets/images/logo-text.png';
}

class MessagesConstant {
  static String noInternetMsg =
      "No internet connection found. Check your connection or try again.";
  static String error = "Error";
}
