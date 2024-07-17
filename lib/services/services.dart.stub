import 'dart:io';

import 'package:alice/alice.dart';
import 'package:cgen/app.dart';
import 'package:cgen/constants/prefs.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiClient {
  Dio _dio = Dio();
  bool isAuth;

  ApiClient({this.isAuth = false}) {
    Alice alice = Alice(
      showNotification: _showNotificationAlice(),
      showInspectorOnShake: debug ? true : false,
      navigatorKey: getKey,
    );

    _dio = Dio(
      BaseOptions(
        baseUrl: env.config.baseUrl,
        connectTimeout: const Duration(milliseconds: 20000),
        receiveTimeout: const Duration(milliseconds: 20000),
      ),
    );

    if (debug) {
      _dio.interceptors.add(
        PrettyDioLogger(
          error: true,
          request: true,
          requestBody: true,
          requestHeader: true,
          responseBody: true,
          responseHeader: true,
          compact: true,
          maxWidth: 500,
        ),
      );
      _dio.interceptors.add(alice.getDioInterceptor());
    }
  }

  Future<Response?> getData(
      String endpoint, {
        Map<String, dynamic>? headers,
        Map<String, dynamic>? queryParameters,
      }) async {
    try {
      String token = prefs.read(PrefsConsts.token) ?? "";
      _dio.options.headers['authorization'] = "Bearer " + token;
      Map<String, dynamic> tempHeaders = {};
      if (headers != null) {
        tempHeaders = headers;
      } else {
        tempHeaders = {
          "content-Type": "application/json",
          "Content-Type": "application/json; charset=UTF-8"
        };
      }
      headers = tempHeaders;

      final response = await _dio.get(
        Uri.encodeFull(endpoint),
        options: Options(headers: headers),
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      throw (await _handleError(e));
    } catch (e) {
      debugPrint("ERROR getData $e");
      throw Exception(e);
    }
  }

  Future<Response?> postData(String endpoint, dynamic data,
      {Map<String, dynamic>? headers}) async {
    try {
      String token = prefs.read(PrefsConsts.token) ?? "";

      _dio.options.headers['authorization'] = "Bearer " + token;
      Map<String, dynamic> tempHeaders = {};
      if (headers != null) {
        tempHeaders = headers;
      } else {
        tempHeaders = {
          "content-Type": "application/json",
          "Content-Type": "application/json; charset=UTF-8"
        };
      }
      headers = tempHeaders;
      final response = await _dio.post(
        Uri.encodeFull(endpoint),
        data: data,
        options: Options(headers: headers),
      );
      return response;
    } on DioException catch (e) {
      throw (await _handleError(e));
    } catch (e) {
      debugPrint("ERROR postData $e");
      throw Exception(e);
    }
  }

  Future<Response?> patchData(String endpoint, dynamic data,
      {Map<String, dynamic>? headers}) async {
    try {
      String token = prefs.read(PrefsConsts.token) ?? "";

      _dio.options.headers['authorization'] = "Bearer " + token;
      Map<String, dynamic> tempHeaders = {};
      if (headers != null) {
        tempHeaders = headers;
      } else {
        tempHeaders = {
          "content-Type": "application/json",
          "Content-Type": "application/json; charset=UTF-8"
        };
      }
      headers = tempHeaders;
      final response = await _dio.patch(
        Uri.encodeFull(endpoint),
        data: data,
        options: Options(headers: headers),
      );
      return response;
    } on DioException catch (e) {
      throw (await _handleError(e));
    } catch (e) {
      debugPrint("ERROR postData $e");
      throw Exception(e);
    }
  }

  Future<Response?> putData(String endpoint, dynamic data,
      {Map<String, dynamic>? headers}) async {
    try {
      String token = prefs.read(PrefsConsts.token) ?? "";

      _dio.options.headers['authorization'] = "Bearer " + token;
      Map<String, dynamic> tempHeaders = {};
      if (headers != null) {
        tempHeaders = headers;
      } else {
        tempHeaders = {
          "content-Type": "application/json",
          "Content-Type": "application/json; charset=UTF-8"
        };
      }
      headers = tempHeaders;
      final response = await _dio.put(
        Uri.encodeFull(endpoint),
        data: data,
        options: Options(headers: headers),
      );
      return response;
    } on DioException catch (e) {
      throw (await _handleError(e));
    } catch (e) {
      debugPrint("ERROR postData $e");
      throw Exception(e);
    }
  }

  Future<Response?> deleteData(String endpoint,
      {Map<String, dynamic>? headers}) async {
    try {
      String token = prefs.read(PrefsConsts.token) ?? "";

      _dio.options.headers['authorization'] = "Bearer " + token;
      Map<String, dynamic> tempHeaders = {};
      if (headers != null) {
        tempHeaders = headers;
      } else {
        tempHeaders = {
          "content-Type": "application/json",
          "Content-Type": "application/json; charset=UTF-8"
        };
      }
      headers = tempHeaders;
      final response = await _dio.delete(
        Uri.encodeFull(endpoint),
        options: Options(headers: headers),
      );
      return response;
    } on DioException catch (e) {
      throw (await _handleError(e));
    } catch (e) {
      debugPrint("ERROR postData $e");
      throw Exception(e);
    }
  }

  Future<Response?> postMultipartData(String endpoint,
      {Map<String, dynamic>? headers,
        required File file,
        required String paramName,
        required String filename,
        required String fileType,
        required String type}) async {
    final multipartData = FormData.fromMap({
      "fileType": fileType,
      "type": type,
      paramName: await MultipartFile.fromFile(file.path, filename: filename),
    });
    final formData = multipartData;
    return postData(endpoint, formData, headers: headers);
  }

  Future<String> _handleError(DioException e) async {
    String msg = "Unknown Error";
    if (e.type == DioExceptionType.connectionError) {
      msg = 'Tidak ada koneksi internet';
    } else if (e.type == DioExceptionType.unknown) {
      msg = 'Unknown Error';
    } else if (e.type == DioExceptionType.connectionTimeout) {
      msg = 'Connection Time Out';
    }
    String errorConnection = "Failed host lookup";
    String unreachable = "Network is unreachable";
    if (e.error.toString().contains(errorConnection) ||
        e.error.toString().contains(unreachable)) {
      msg = 'No internet connection';
    }
    msg = e.response?.statusMessage ?? "Unknown Error";
    return msg;
  }

  _showNotificationAlice() {
    if(showAlice){
      if (Platform.isAndroid) {
        if (debug) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    }else{
      return false;
    }
  }
}