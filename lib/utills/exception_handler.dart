import 'dart:async';
import 'package:get/get.dart';
import 'package:recipesapp/api/response_handler.dart';
import 'dart:io';

import 'package:recipesapp/utills/app_constants.dart';
import 'package:recipesapp/utills/global_utills.dart';

class ExceptionData {
  String? title;
  String? message;
  int code;
  ExceptionData({this.title, this.message, this.code = -1});
}

class ExceptionHandler {
  static final ExceptionHandler _exceptionHandler =
      ExceptionHandler._internal();
  ExceptionHandler._internal();
  factory ExceptionHandler() => _exceptionHandler;

  Future<ExceptionData> handleException(Exception e,
      {bool showDialog = true}) async {
    var data = _makeException(e);

    if (showDialog) {
      if (data.message!.trim().toLowerCase() == "internal server error") {
        // need to create generic app dialog widget then uncomment this line.
        // await Get.dialog(
        //     GenericAppDialog(
        //       message: "System unavailable",
        //     ),
        //     barrierDismissible: false);
      } else if (data.code == 401 &&
          authenticator.getAuthToken != null &&
          authenticator.getAuthToken.replaceAll("bearer ", "").isNotEmpty) {
        // invalid token clear, logout and nav to splash screen.
        authenticator.setAuthToken = "";
      } else {
        print("other +++");
        // need to create generic app dialog widget then uncomment this line.
        //   await Get.dialog(
        //       GenericAppDialog(
        //         headingText: "Error",
        //         message: data.message,
        //       ),
        //       barrierDismissible: false);
        // }
      }
    }
    return data;
  }

  ExceptionData _makeException(Exception e) {
    switch (e.runtimeType) {
      case TimeoutException:
        return ExceptionData(
            title: "Service timed out",
            message: MessagesConstant.noInternetMsg);
      case SocketException:
        return ExceptionData(
            title: "Connection error",
            message: "Please check your internet connection then retry");
      case HttpException:
        return ExceptionData(
            title: "Error", message: (e as HttpCustomException).message);
      case HttpCustomException:
        return ExceptionData(
            title: "Error",
            message: (e as HttpCustomException).message,
            code: (e as HttpCustomException).code!);
      case BadRequestException:
        return ExceptionData(
            title: "Bad Request Exception", message: "Bad request");
      case UnauthorizedAccessException:
        return ExceptionData(
            title: "Unauthorized Access Exception",
            message: "Unauthorized access exception");
      case ResourceNotFoundException:
        return ExceptionData(
            title: "Resource Not Found Exceptio",
            message: "Bad Request Exception");
      default:
        return ExceptionData(
            title: "Error", message: "Unable to process request.");
    }
  }
}
