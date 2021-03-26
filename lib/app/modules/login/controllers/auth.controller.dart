import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


import 'package:ru_agenda/app/data/models/user.model.dart';
import 'package:ru_agenda/app/data/repositories/user.repository.dart';
import 'package:ru_agenda/app/routes/app_pages.dart';
import 'package:ru_agenda/app/utils/http_utils.dart';
import 'package:ru_agenda/app/utils/keys.dart';

class AuthController extends GetxController {
  final UserRepository repository;
  AuthController({@required this.repository}) : assert(repository != null);
  static AuthController get to => Get.find<AuthController>();

  final _store = GetStorage();
  Rx<UserModel> loggedUser = Rx<UserModel>();
  RxBool isLoggedIn = RxBool(false);

  @override
  void onInit() {
    // TODO: implement onInit
    //await ()
    super.onInit();
  }

  @override
  void onReady() async {
    // TODO: implement onReady
    ever(isLoggedIn, handleAuthChanged);
    await verifyUser();
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }


  Future<void> verifyUser() async {
    final storedToken = await _store.read(AppStorageKey.ACCESS_TOKEN);
    if (storedToken != null) {
      try {
        loggedUser.value = await repository.getProfile();
        isLoggedIn.value = true;
      } catch (e) {
        loggedUser.value = null;
        isLoggedIn.value = false;
      }
    } else {
      loggedUser.value = null;
      isLoggedIn.value = false;
    }
  }

  handleAuthChanged(isLoggedIn) async {
    if (isLoggedIn) {
      Get.offAllNamed(Routes.HOME);
    } else {
      Get.offAllNamed(Routes.LOGIN);
    }
  }

  Future<void> setLoggedUser(LoginResponseModel loginResponse) async {
    loggedUser.value = loginResponse.user;
    isLoggedIn.value = true;
    await _store.write(AppStorageKey.ACCESS_TOKEN, loginResponse.token);
    await _store.write(AppStorageKey.REFRESH_TOKEN, loginResponse.refreshToken);
    Get.toNamed(Routes.HOME);
  }
}
