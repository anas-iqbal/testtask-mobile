import 'package:flutter/material.dart';

// not required in this app
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
  bool isTablet() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance!.window);
    return data.size.shortestSide < 600 ? false : true;
  }
}

class GlobalConstants {
  static const dateFormat = "yyyy-MM-dd";
}

final GlobalCache globalCache = GlobalCache();
final Authenticator authenticator = Authenticator();
