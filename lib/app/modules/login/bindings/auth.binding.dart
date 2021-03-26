import 'package:get/get.dart';

import 'package:ru_agenda/app/data/providers/user.provider.dart';
import 'package:ru_agenda/app/data/repositories/user.repository.dart';
import 'package:ru_agenda/app/modules/login/controllers/auth.controller.dart';

class AuthBinding extends Bindings {
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
  }
}
