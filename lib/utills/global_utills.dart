import 'package:flutter/material.dart';

class Authenticator {
  String _authToken = '';

  set setAuthToken(String token) {
    _authToken = token;
  }

  String get getAuthToken {
    return _authToken;
  }
}

class GlobalCache {
  String versionName = "";

  bool isTablet() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance!.window);
    return data.size.shortestSide < 600 ? false : true;
  }
}

class GlobalConstants {
  static const usernameKey = "username";
  static const passKey = "password";
  static const dateFormat = "MM-dd-yyyy hh:mm a";
}

final GlobalCache globalCache = GlobalCache();
final Authenticator authenticator = Authenticator();
