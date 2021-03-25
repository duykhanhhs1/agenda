import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:ru_agenda/app/data/mock/app.mock.dart';
import 'package:ru_agenda/app/data/models/user.model.dart';
import 'package:ru_agenda/app/utils/http_utils.dart';

class UserProvider extends GetConnect {
  Future<LoginResponseModel> verifyUser({String username, String password}) async {
    // try{
    //   final response = await HttpHelper.post(/*Endpoints.VERIFY_EMAIL*/'link-api', {
    //     'username': username,
    //     'password': password,
    //   });
    //   return UserModel.fromJson(response.body);
    // }on DioError catch (e) {
    //   return UserModel();
    // }

    return AppMock.loginResponse;
  }
}