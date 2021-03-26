import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:ru_agenda/app/routes/app_pages.dart';
import 'package:ru_agenda/app/theme/app_theme.dart';

void main() async {
  await GetStorage.init();

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RU-Agenda Application',
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: appThemeData,
      defaultTransition: Transition.fadeIn,
    ),
  );
}
