import 'package:get/get.dart';

import 'package:ru_agenda/app/data/providers/user.provider.dart';
import 'package:ru_agenda/app/data/repositories/user.repository.dart';
import 'package:ru_agenda/app/modules/login/controllers/base.controller.dart';
import 'package:ru_agenda/app/modules/login/controllers/login.controller.dart';

class BaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<BaseController>(
      BaseController(),
      permanent: true,
    );
  }
}
