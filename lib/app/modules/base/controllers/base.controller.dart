import 'dart:convert';
import 'package:get/get.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

import 'package:gm_pms/app/data/models/view_argument.model.dart';
import 'package:gm_pms/app/modules/auth/controllers/auth.controller.dart';
import 'package:gm_pms/app/routes/app_pages.dart';
import 'package:gm_pms/app/utils/http_utils.dart';

class BaseController extends GetxController {
  final AuthController _authController = AuthController.to;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    _initDynamicLinks();
    //
    super.onReady();
  }

  @override
  void onClose() {}

  Future<void> _initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink(
      onSuccess: (PendingDynamicLinkData dynamicLink) async {
        final Uri deepLink = dynamicLink?.link;
        if (deepLink != null) {
          _navigateDeepLink(deepLink);
        }
      },
      onError: (OnLinkErrorException e) async {},
    );

    final PendingDynamicLinkData dynamicLink =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = dynamicLink?.link;
    if (deepLink != null) {
      _navigateDeepLink(deepLink);
    }
  }

  void _navigateDeepLink(Uri deepLink) async {
    final token = HttpHelper.getUriQueryParam(deepLink, 'token');

    if (deepLink != null && token != null) {
      final data = jsonDecode(token);
      //
      final questionnaireNo = data['questionnaireNo'];
      final accessToken = data['accessToken'];
      final refreshToken = data['refreshToken'];
      //
      if (accessToken != null && refreshToken != null) {
        await _authController.loadUserByToken(accessToken: accessToken, refreshToken: refreshToken);
      }
      if (questionnaireNo != null) {
        Get.toNamed(
          Routes.QUESTIONNAIRE,
          arguments: QuestionnaireViewArgument(questionnaireNo: questionnaireNo),
        );
      }
    }
  }
}
