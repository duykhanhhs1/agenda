import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ru_agenda/app/data/models/user.model.dart';
import 'package:ru_agenda/app/data/repositories/user.repository.dart';
import 'package:ru_agenda/app/modules/login/controllers/auth.controller.dart';

class LoginController extends GetxController {
  final UserRepository repository;

  LoginController({@required this.repository}) : assert(repository != null);

  final AuthController _authController = AuthController.to;


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
    await _authController.setLoggedUser(loginResponse);
    update();
  }


}
