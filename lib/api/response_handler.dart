import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ResponseHandler {
  MappedResponse<dynamic> processResponse(dynamic response) {
    try {
      if (!kReleaseMode) {
        print(response.statusCode);
        print(response.data);
      }
      if (!((response.statusCode! < 200) ||
          (response.statusCode! >= 300) ||
          (response.data == null))) {
        var body = response.data != null && response.data.isNotEmpty
            ? response.data
            : response.statusCode;
        return MappedResponse<dynamic>(
            code: response.statusCode,
            success: true,
            message: "Success",
            content: body);
      } else {
        var dataMsg = response.data['message'];
        // var message = _extractErrorMessage(dataMsg);

        return MappedResponse<dynamic>(
            code: response.statusCode,
            success: false,
            message: dataMsg,
            content: dataMsg);
      }
    } catch (e) {
      throw e;
    }
  }

  String _extractErrorMessage(body) {
    String errorMessage = "Failed to process request";
    if (body['errors'] != null) {
      var keys = body['errors'].keys.toList();
      List values = body['errors'].values.toList();
      if (body["title"].toString().isNotEmpty) {
        if (values.isNotEmpty) errorMessage = values[0].first.toString();
      } else {
        errorMessage = '${keys[0]}: ${body["title"]}';
      }
    } else if (body['response'] != null) {
      if (body['response']['Message'] != null) {
        errorMessage = body['response']['Message'];
      } else if (body['response']['message'] != null) {
        errorMessage = body['response']['message'];
      }
    } else if (body['error_description'] != null) {
      errorMessage = body['error_description'];
    } else if (body['message'] != null) {
      errorMessage = body['message'];
    } else if (body['Message'] != null) {
      errorMessage = body['Message'];
    } else if (body['errorCategory'] != null) {
      errorMessage = body['errorCategory'];
    } else if (body['errorDescription'] != null) {
      errorMessage = body['errorDescription'];
    } else if (body['error'] != null) {
      errorMessage = body['error'];
    } else if (body['responseDesc'] != null) {
      errorMessage = body['responseDesc'];
    }
    return errorMessage;
  }
}

class HttpCustomException implements IOException {
  int? code;
  String? message;
  String apiCode;

  HttpCustomException({this.code, this.message, this.apiCode = ''});

  @override
  String toString() {
    var b = StringBuffer()..write(message);
    return b.toString();
  }
}

class BadRequestException extends HttpException {
  BadRequestException({String message = 'The request is invalid.'})
      : super(message);

  @override
  String toString() {
    var b = StringBuffer()
      ..write('BadRequestException: ')
      ..write(message);
    return b.toString();
  }
}

class UnauthorizedAccessException extends HttpException {
  UnauthorizedAccessException(
      {String message = 'User not allowed to perform this operation'})
      : super(message);

  @override
  String toString() {
    var b = StringBuffer()
      ..write('UnauthorizedAccessException: ')
      ..write(message);
    return b.toString();
  }
}

class ResourceNotFoundException extends HttpException {
  ResourceNotFoundException({String message = ''}) : super(message);

  @override
  String toString() {
    var b = StringBuffer()
      ..write('ResourceNotFoundException: ')
      ..write(message);
    return b.toString();
  }
}

class MappedResponse<T> {
  int? code;
  bool? success;
  dynamic content;
  String? message;
  String errorCode;

  MappedResponse(
      {this.code,
      this.content,
      this.message,
      this.success,
      this.errorCode = ''});
}
