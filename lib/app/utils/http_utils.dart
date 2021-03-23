import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:ru_agenda/app/utils/dio_interceptors.dart';



class HttpResponse {
  final Response originalResponse;
  final int statusCode;
  final dynamic body;

  HttpResponse({this.originalResponse, this.statusCode, this.body});
}

class HttpHelper {
  static getDio() {
    Dio _dio = Dio();
    _dio.interceptors.add(DioInterceptors(_dio));
    return _dio;
  }

  static Future<HttpResponse> get(String url) async {
    final dio = HttpHelper.getDio();
    final response = await dio.get(url);
    return HttpResponse(
      originalResponse: response,
      statusCode: response.statusCode,
      body: response.data,
    );
  }

  static Future<HttpResponse> post(String url, Object data) async {
    final dio = HttpHelper.getDio();
    final response = await dio.post(url, data: data);
    return HttpResponse(
      originalResponse: response,
      statusCode: response.statusCode,
      body: response.data,
    );
  }

  static Future<HttpResponse> put(String url, Object data) async {
    final dio = HttpHelper.getDio();
    final response = await dio.put(url, data: data);
    return HttpResponse(
      originalResponse: response,
      statusCode: response.statusCode,
      body: response.data,
    );
  }

  static Future<HttpResponse> delete(String url, [Object data]) async {
    final dio = HttpHelper.getDio();
    final response = await dio.delete(url, data: data);
    return HttpResponse(
      originalResponse: response,
      statusCode: response.statusCode,
      body: response.data,
    );
  }

  static Future<HttpResponse> uploadFile(String url,
      {@required File file}) async {
    final dio = HttpHelper.getDio();
    final uploadFile = await MultipartFile.fromFile(
      file.path,
      filename: basename(file.path),
    );
    final formData = FormData.fromMap({'file': uploadFile});
    final response = await dio.post(url, data: formData);
    return HttpResponse(
      originalResponse: response,
      statusCode: response.statusCode,
      body: response.data,
    );
  }

  static String getUriQueryParam(Uri uri, String key) {
    final queryParams = uri.queryParametersAll?.entries?.toList();
    if (queryParams.any((_) => _.key == key)) {
      return queryParams.firstWhere((_) => _.key == key).value.first;
    }
    return null;
  }
}
