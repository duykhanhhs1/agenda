import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ru_agenda/app/utils/endpoints.dart';
import 'package:ru_agenda/app/utils/http_utils.dart';


import 'package:ru_agenda/app/utils/keys.dart';

class DioInterceptors extends InterceptorsWrapper {
  final Dio _dio;
  final _store = GetStorage();
  //final AuthController _authController = AuthController.to;

  DioInterceptors(this._dio);

  @override
  Future onRequest(RequestOptions options) async {
    String accessToken = _store.read(AppStorageKey.ACCESS_TOKEN);

    options.headers
        .addAll({HttpHeaders.authorizationHeader: '${AppStorageKey.TOKEN_TYPE} $accessToken'});
    return options;
  }

  @override
  Future onResponse(Response response) {
    return super.onResponse(response);
  }

  // @override
  // Future onError(DioError dioError) async {
  //   String oldAccessToken = _store.read(AppStorageKey.ACCESS_TOKEN);
  //   int responseCode = dioError.response.statusCode;
  //
  //   if (oldAccessToken != null && responseCode == 401) {
  //     print('refresh accessToken');
  //     _dio.interceptors.requestLock.lock();
  //     _dio.interceptors.responseLock.lock();
  //     //
  //     try {
  //       String refreshToken = _store.read(AppStorageKey.REFRESH_TOKEN) ?? '';
  //       final response = await HttpHelper.post('${Endpoints.REFRESH_TOKEN}', {'refreshToken': refreshToken});
  //       //
  //       final tokenData = RefreshTokenResponse.fromJson(response.body);
  //       await _store.write(AppStorageKey.ACCESS_TOKEN, tokenData.accessToken);
  //       await _store.write(AppStorageKey.REFRESH_TOKEN, tokenData.refreshToken);
  //     } catch (e) {
  //       super.onError(dioError);
  //       _authController.logout();
  //     }
  //     //
  //     RequestOptions options = dioError.response.request;
  //     _dio.interceptors.requestLock.unlock();
  //     _dio.interceptors.responseLock.unlock();
  //     return _dio.request(options.path, options: options);
  //   } else {
  //     super.onError(dioError);
  //   }
  // }
}
