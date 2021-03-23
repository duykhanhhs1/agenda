import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:gm_pms/app/modules/auth/controllers/auth.controller.dart';
import 'package:gm_pms/app/routes/app_pages.dart';
import 'package:gm_pms/app/theme/app_theme.dart';
import 'package:gm_pms/app/theme/color_theme.dart';
import 'package:gm_pms/app/utils/version.dart';

class NavigationView extends GetView<AuthController> {
  Widget _buildHeader() {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(
            kHorizontalContentPadding,
            10,
            kHorizontalContentPadding,
            30,
          ),
          width: double.infinity,
          color: kPrimaryColor,
          child: SafeArea(
            child: Column(
              children: [
                Align(
                  child: GestureDetector(
                    onTap: () {
                      Get.offAllNamed(Routes.HOME);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  alignment: Alignment.topLeft,
                ),
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: controller.loggedUser.value.avatar != null
                          ? NetworkImage(controller.loggedUser.value.avatar)
                          : AssetImage('assets/images/avatar-default.png'),
                    ),
                  ),
                ),
                Text(
                  controller.loggedUser.value.fullName,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
          bottom: -2,
          left: 0,
          child: Container(
            width: Get.width,
            height: 15,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          Column(
            children: [
              MenuItem(
                name: "Home",
                icon: Icons.home,
                onTap: () {
                  Get.offAllNamed(Routes.HOME);
                },
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              controller.logout();
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 30, bottom: 20),
              child: Text(
                "Logout",
                style: TextStyle(
                  fontSize: 16,
                  color: kErrorColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Spacer(),
          Center(
            child: Text(
              'App version: ${GetPlatform.isAndroid ? AppVersion.ANDROID_VERSION : AppVersion.IOS_VERSION}',
              style: TextStyle(
                fontSize: 12,
                color: kPrimaryGreyColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(height: 20)
        ],
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final VoidCallback onTap;

  const MenuItem({Key key, this.name, this.onTap, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: kPrimaryBlackColor,
        size: 25,
      ),
      title: Text(
        name,
        style: TextStyle(
            fontSize: 16,
            color: kPrimaryBlackColor,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}
