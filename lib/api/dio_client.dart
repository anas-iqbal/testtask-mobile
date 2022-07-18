import 'package:dio/dio.dart';
import 'package:recipesapp/api/response_handler.dart';
import 'package:recipesapp/utills/app_constants.dart';
import 'package:recipesapp/utills/global_utills.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class DioClient {
  final Dio _dio = Dio()..options.baseUrl = APIConstants.baseURL;

  final ResponseHandler _responseHandler = ResponseHandler();

  Future<dynamic> get(String endpoint,
      {Map<String, dynamic>? queryParam}) async {
    Map<String, dynamic> queryParam = {};
    queryParam = queryParam;

    await checkInternetAvailable();
    try {
      var res = await _dio.get(endpoint,
          queryParameters: queryParam,
          options: Options(headers: {
            // "authorization": "Bearer " + authenticator.getAuthToken,
            "accept": "application/json"
          }));
      MappedResponse processed = _responseHandler.processResponse(res);
      return _returnResponse(processed);
    } on DioError catch (e) {
      MappedResponse processed = _responseHandler.processResponse(e.response);
      return _returnResponse(processed);
    }
  }

  Future<dynamic> post(String endpoint, {Map<String, dynamic>? body}) async {
    Map<String, dynamic> queryParam = {};
    if (body != null) {
      queryParam = body;
    }
    await checkInternetAvailable();
    var res = await _dio.post(APIConstants.baseURL + endpoint,
        queryParameters: queryParam,
        options: Options(headers: {
          "authorization": "Bearer " + authenticator.getAuthToken,
          "accept": "application/json"
        }));
    MappedResponse processed = _responseHandler.processResponse(res);
    return _returnResponse(processed);
  }

  _returnResponse(MappedResponse processed) {
    if (processed.success ?? false) {
      return processed.content;
    } else {
      throw HttpCustomException(
          code: processed.code,
          message: processed.message,
          apiCode: processed.errorCode);
    }
  }

  Future<void> checkInternetAvailable() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return;
    } else {
      throw HttpCustomException(
          code: 8000, message: "Please Check your internet connection.");
    }
  }
}
