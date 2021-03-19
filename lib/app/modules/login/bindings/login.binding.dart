
import 'package:get/get.dart';


import 'package:ru_agenda/app/modules/login/controllers/login.controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
          () => LoginController(),
    );
  }
}
