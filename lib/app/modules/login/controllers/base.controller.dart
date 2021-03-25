import 'package:get/get.dart';
import 'package:ru_agenda/app/modules/login/controllers/login.controller.dart';

class BaseController extends GetxController {
  static LoginController get to => Get.find<LoginController>();

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
}
