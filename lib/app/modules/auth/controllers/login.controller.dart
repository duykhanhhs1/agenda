import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:gm_pms/app/data/models/user.model.dart';
import 'package:gm_pms/app/data/repositories/user.repository.dart';
import 'package:gm_pms/app/modules/auth/controllers/auth.controller.dart';
import 'package:gm_pms/app/routes/app_pages.dart';
import 'package:gm_pms/app/utils/http_utils.dart';

class LoginController extends GetxController {
  final AuthController _authController = AuthController.to;
  final UserRepository repository;
  LoginController({@required this.repository}) : assert(repository != null);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool isProcessing = false.obs;
  RxBool isSelectingUser = false.obs;
  Rx<UserProfileModel> selectedUserProfile = Rx<UserProfileModel>();
  RxList profiles = [].obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailController?.dispose();
    passwordController?.dispose();
    super.onClose();
  }

  Future<void> loginUser() async {
    if (selectedUserProfile.value == null) {
      Get.snackbar(
        'Error',
        'Please select a user.',
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 2),
        backgroundColor: Colors.white,
        colorText: Colors.red,
      );
      return;
    }

    if (isProcessing.value) return;

    try {
      isProcessing.value = true;
      HttpResponse response = await repository.loginUser(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        userNo: selectedUserProfile.value.userNo,
        agencyNo: selectedUserProfile.value.agencyNo,
      );
      //
      final loginResponse = LoginResponseModel.fromJson(response.body);
      await _authController.setLoggedUser(loginResponse);
      //
      Get.toNamed(Routes.HOME);
      //
      isProcessing.value = false;
    } on DioError catch (e) {
      if (e.response.statusCode == 401) {
        Get.snackbar(
          'Failed',
          'Invalid user. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
          colorText: Colors.red,
        );
      } else {
        Get.snackbar(
          'Error',
          'An error has occurred. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
          colorText: Colors.red,
        );
      }
      isProcessing.value = false;
    }
  }

  Future<void> selectUserProfile(UserProfileModel userProfile) async {
    selectedUserProfile.value = userProfile;
  }

  Future<void> verifyUser() async {
    isProcessing.value = true;
    try {
      HttpResponse response = await repository.verifyUser(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      //
      final userProfiles =
          response.body.map((_) => UserProfileModel.fromJson(_)).toList();
      profiles.clear();
      profiles.addAll(userProfiles);
      //
      isProcessing.value = false;
      //
      if (profiles.length == 1) {
        selectedUserProfile.value = userProfiles[0];
        loginUser();
      } else {
        selectedUserProfile.value = null;
        Get.toNamed(Routes.LOGIN_SELECT_USER);
      }
    } on DioError catch (e) {
      if (e.response.statusCode == 401) {
        Get.snackbar(
          'Failed',
          'Incorrect email/password. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
          colorText: Colors.red,
        );
      } else {
        Get.snackbar(
          'Error',
          'An error has occurred. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
          colorText: Colors.red,
        );
      }
      isProcessing.value = false;
    }
  }
}
