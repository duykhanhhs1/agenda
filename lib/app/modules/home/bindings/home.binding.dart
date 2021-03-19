import 'package:get/get.dart';
import 'package:ru_agenda/app/data/providers/class.provider.dart';
import 'package:ru_agenda/app/data/repositories/class.repository.dart';
import 'package:ru_agenda/app/modules/home/controllers/home.controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(
        repository: ClassRepository(
          apiClient: ClassProvider(),
        ),
      ),
    );
  }
}
