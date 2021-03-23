import 'package:get/get.dart';

import 'package:gm_pms/app/data/providers/user.provider.dart';
import 'package:gm_pms/app/data/repositories/user.repository.dart';
import 'package:gm_pms/app/modules/auth/controllers/auth.controller.dart';
import 'package:gm_pms/app/modules/base/controllers/base.controller.dart';

class BaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(
      AuthController(
        repository: UserRepository(
          apiClient: UserProvider(),
        ),
      ),
      permanent: true,
    );
    Get.put<BaseController>(
      BaseController(),
      permanent: true,
    );
  }
}
