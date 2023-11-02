import 'dart:async';

import 'package:dio/dio.dart';

class ApiUtil {
  bool logoutLock = false;
  late Dio _dio;

  ApiUtil() {
    init();
  }

  init() {
    initializeDioForApi();
  }

  void initializeDioForApi() {
    String baseUrl = 'https://www.googleapis.com/calendar/v3/calendars/';

    _dio = Dio(
      BaseOptions(
          connectTimeout: const Duration(seconds: 100), baseUrl: baseUrl),
    );
  }

  Future post({
    required String path,
    Map? body,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
    Map<String, dynamic>? queryParameters,
  }) async {
    Response response = await _dio.post(
      path,
      data: body,
      options: Options(headers: headers),
      cancelToken: cancelToken,
      queryParameters: queryParameters,
    );
    return response.data;
  }
}
