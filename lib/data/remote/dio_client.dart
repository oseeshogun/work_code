import 'dart:io';

import 'package:codedutravail/core/config/env.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_client.g.dart';

@Riverpod(keepAlive: true)
Dio dioClient(Ref ref) {
  return DioClient.create(baseUrl: Env.llmApiUrl);
}

abstract class DioClient {
  static Dio create({required String baseUrl}) {
    final Dio dio = Dio();

    dio.options.baseUrl = baseUrl;

    // ignore: deprecated_member_use
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };

    dio.interceptors.add(
      PrettyDioLogger(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        enabled: kDebugMode,
        logPrint: (object) => debugPrint(object.toString()),
        filter: (options, args) {
          // debugPrint requests of these urls
          final List<String> urls = [''];
          if (urls.any((url) => options.uri.path.contains(url))) return true;

          return !args.isResponse;
        },
      ),
    );

    Map<String, dynamic> headers = {
      'X-Requested-With': 'XMLHttpRequest',
      'Accept': 'application/json',
      'Content-Type': 'application/json;charset=UTF-8',
    };

    dio.options.headers.addAll(headers);

    dio.interceptors.add(PlayIntegrityApiInterceptor());

    return dio;
  }
}

class PlayIntegrityApiInterceptor extends Interceptor {
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await FirebaseAppCheck.instance.getToken();

    if (token != null) {
      options.headers['X-Firebase-AppCheck'] = token;
    }

    return handler.next(options);
  }
}
