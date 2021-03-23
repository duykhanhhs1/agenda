import 'package:get/get.dart';

import 'package:gm_pms/app/data/providers/user.provider.dart';
import 'package:gm_pms/app/data/repositories/user.repository.dart';
import 'package:gm_pms/app/modules/auth/controllers/forgot_password.controller.dart';
import 'package:gm_pms/app/modules/auth/controllers/login.controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(
        repository: UserRepository(
          apiClient: UserProvider(),
        ),
      ),
    );
    Get.lazyPut<ForgotPasswordController>(() => ForgotPasswordController());
  }
}
