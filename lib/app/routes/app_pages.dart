import 'package:get/get.dart';


import 'package:ru_agenda/app/modules/home/bindings/home.binding.dart';
import 'package:ru_agenda/app/modules/home/views/home.view.dart';
import 'package:ru_agenda/app/modules/login/bindings/login.binding.dart';
import 'package:ru_agenda/app/modules/login/views/login.view.dart';
import 'package:ru_agenda/app/modules/login/views/splash.view.dart';


part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.LOGIN;

  static final routes = [
    // GetPage(
    //   name: Routes.SPLASH,
    //   page: () => SplashView(),
    //   binding: LoginBinding(),
    // ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
  ];
}
