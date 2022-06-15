import 'package:sobe/modules/authentication/bloc/authentication_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:dio/dio.dart';
import '../../env/env.dart';
import 'error_message.dart';
import 'dart:io';

const _defaultConnectTimeout = Duration.millisecondsPerMinute;
const _defaultReceiveTimeout = Duration.millisecondsPerMinute;

class DioClient {
  final String baseUrl = environment['baseUrl']!;
  final Dio _dio;
  final List<Interceptor>? interceptors;
  static AuthenticationBloc? authenticationBloc;
  var logger = Logger(printer: PrettyPrinter());

  DioClient(
    this._dio, {
    this.interceptors,
  }) {
    _dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = _defaultConnectTimeout
      ..options.receiveTimeout = _defaultReceiveTimeout
      ..httpClientAdapter
      ..options.headers = {'Content-Type': 'application/json; charset=UTF-8'};
    if (interceptors?.isNotEmpty ?? false) {
      _dio.interceptors.addAll(interceptors!);
    }
    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(
          responseBody: true,
          error: true,
          requestHeader: false,
          responseHeader: false,
          request: false,
          requestBody: false));
    }
  }

  Future<dynamic> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on DioError catch (dioError) {
      _handleDioError(dioError);
    } catch (e) {
      _handleError(e);
    }
  }

  Future<dynamic> put(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var accessToken = prefs.getString('access');

      var response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: {
          Headers.contentTypeHeader: Headers.jsonContentType,
          HttpHeaders.authorizationHeader: "Bearer $accessToken",
        }),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } on DioError catch (dioError) {
      _handleDioError(dioError);
    } catch (e) {
      _handleError(e);
    }
  }

  Future<dynamic> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on DioError catch (dioError) {
      _handleDioError(dioError);
    } catch (e) {
      _handleError(e);
    }
  }

  Future<dynamic> patch(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var accessToken = prefs.getString('access');

      var response = await _dio.patch(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: {
          Headers.contentTypeHeader: Headers.jsonContentType,
          HttpHeaders.authorizationHeader: "Bearer $accessToken",
        }),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on DioError catch (dioError) {
      _handleDioError(dioError);
    } catch (e) {
      _handleError(e);
    }
  }

  Future<dynamic> delete(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var accessToken = prefs.getString('access');

      var response = await _dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: {
          Headers.contentTypeHeader: Headers.jsonContentType,
          HttpHeaders.authorizationHeader: "Bearer $accessToken",
        }),
        cancelToken: cancelToken,
      );
      return response.data;
    } on DioError catch (dioError) {
      _handleDioError(dioError);
    } catch (e) {
      _handleError(e);
    }
  }

  Future<dynamic> getWithAuth(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var accessToken = prefs.getString('access');

      print('===========access token==================');
      print(accessToken);
      print('=====================================');

      var response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: Options(headers: {
          Headers.contentTypeHeader: Headers.jsonContentType,
          HttpHeaders.authorizationHeader: "Bearer $accessToken",
        }),
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } on DioError catch (dioError) {
      _handleDioError(dioError);
    } catch (e) {
      _handleError(e);
    }
  }

  Future<dynamic> postWithAuth(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var accessToken = prefs.getString('access');

      var response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: {
          Headers.contentTypeHeader: Headers.jsonContentType,
          HttpHeaders.authorizationHeader: "Bearer $accessToken",
        }),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } on DioError catch (dioError) {
      _handleDioError(dioError);
      return dioError;
    } catch (e) {
      _handleError(e);
    }
  }

  _handleDioError(DioError dioError) {
    print("]-----] DioUtil::_handleDioError [-----[ $dioError");
    print("]-----] response ${dioError.response}");
    print("]-----] response ${dioError.response?.data['errorMsg']}");

    if (dioError.response != null) {
      if (dioError.response?.data['errorMsg'] != null) {
        throw dioError;
      } else {
        throw dioError;
      }
    } else {
      if (dioError.error is SocketException) {
        throw Exception(ErrorMessage.getValue(999));
      } else {
        throw Exception(dioError.response?.data['errorMsg']);
      }
    }
  }

  _handleError(error) {
    logger.e("DioUtil::_handleError $error");
    throw Exception(error);
  }

  onError(error) {
    logger.e("DioUtil::onError $error");
  }
}
