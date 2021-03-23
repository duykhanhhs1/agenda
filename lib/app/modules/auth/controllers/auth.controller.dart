import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'package:gm_pms/app/data/repositories/user.repository.dart';
import 'package:gm_pms/app/routes/app_pages.dart';
import 'package:gm_pms/app/utils/http_utils.dart';
import 'package:gm_pms/app/utils/keys.dart';
import 'package:gm_pms/app/data/models/user.model.dart';

class AuthController extends GetxController {
  final UserRepository repository;
  AuthController({@required this.repository}) : assert(repository != null);

  static AuthController get to => Get.find<AuthController>();
  final _store = GetStorage();
  Rx<UserModel> loggedUser = Rx<UserModel>();
  RxBool isLoggedIn = RxBool(false);

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    //Run every time auth state changes
    ever(isLoggedIn, handleAuthChanged);
    await verifyUser();
    super.onReady();
  }

  @override
  void onClose() {}

  Future<void> verifyUser() async {
    final storedToken = await _store.read(AppStorageKey.ACCESS_TOKEN);
    if (storedToken != null) {
      try {
        HttpResponse response = await repository.getProfile();
        loggedUser.value = UserModel.fromJson(response.body);
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

  Future<void> setLoggedUser(LoginResponseModel loginResponse) async {
    loggedUser.value = loginResponse.user;
    isLoggedIn.value = true;
    await _store.write(AppStorageKey.ACCESS_TOKEN, loginResponse.token);
    await _store.write(AppStorageKey.REFRESH_TOKEN, loginResponse.refreshToken);
  }

  Future<void> loadUserByToken({String accessToken, String refreshToken}) async {
    if (!isLoggedIn.value) {
      await _store.write(AppStorageKey.ACCESS_TOKEN, accessToken);
      await _store.write(AppStorageKey.REFRESH_TOKEN, refreshToken);
      await verifyUser();
    }
  }

  handleAuthChanged(isLoggedIn) async {
    if (isLoggedIn) {
      Get.offAllNamed(Routes.HOME);
    } else {
      Get.offAllNamed(Routes.LOGIN);
    }
  }

  Future<void> logout() async {
    loggedUser.value = null;
    isLoggedIn.value = false;
    //
    await _store.remove(AppStorageKey.ACCESS_TOKEN);
    await _store.remove(AppStorageKey.REFRESH_TOKEN);
    //
    Get.offAllNamed(Routes.LOGIN);
  }
}
