import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


import 'package:ru_agenda/app/data/models/user.model.dart';
import 'package:ru_agenda/app/data/repositories/user.repository.dart';
import 'package:ru_agenda/app/routes/app_pages.dart';
import 'package:ru_agenda/app/utils/keys.dart';

class LoginController extends GetxController {
  final UserRepository repository;

  LoginController({@required this.repository}) : assert(repository != null);

  static LoginController get to => Get.find<LoginController>();

  final _store = GetStorage();

  TextEditingController usernameEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();

   Rx<UserModel> loggedUser = Rx<UserModel>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void verifyUser() async {
    final LoginResponseModel loginResponse = await repository.verifyUser(
        username: usernameEditingController.text,
        password: passwordEditingController.text);
    setLoggedUser(loginResponse);
    update();
  }

  void setLoggedUser(LoginResponseModel loginResponse) async {
    loggedUser.value = loginResponse.user;
    await _store.write(AppStorageKey.ACCESS_TOKEN, loginResponse.token);
    await _store.write(AppStorageKey.REFRESH_TOKEN, loginResponse.refreshToken);

    Get.toNamed(Routes.HOME);
  }
}
