import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:gm_pms/app/data/models/user.model.dart';
import 'package:gm_pms/app/modules/auth/controllers/login.controller.dart';
import 'package:gm_pms/app/theme/app_theme.dart';
import 'package:gm_pms/app/theme/color_theme.dart';
import 'package:gm_pms/app/widgets/shadow_box.widget.dart';

class SelectUserView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Please select a user to login'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: controller.profiles.length,
        itemBuilder: (context, index) {
          final UserProfileModel userProfile = controller.profiles[index];
          return InkWell(
            onTap: () {
              controller.selectUserProfile(userProfile);
            },
            child: ShadowBox(
              margin: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: kHorizontalContentPadding,
              ),
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: 5,
                          children: [
                            Text('Full name:'),
                            Text(userProfile.fullName,
                                style: TextStyle(fontWeight: FontWeight.w500)),
                          ],
                        ),
                        Wrap(
                          spacing: 5,
                          children: [
                            Text('Email:'),
                            Text(
                              userProfile.email,
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Wrap(
                          spacing: 5,
                          children: [
                            Text('Mobile:'),
                            Text(
                              userProfile.mobile,
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 5),
                  Obx(
                    () => (controller.selectedUserProfile.value != null &&
                            userProfile.userNo ==
                                controller.selectedUserProfile.value.userNo)
                        ? Icon(
                            Icons.check_circle,
                            color: kPrimaryColor,
                          )
                        : SizedBox(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: FlatButton(
        onPressed: () => controller.loginUser(),
        color: kPrimaryColor,
        height: 70,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        child: Obx(
          () => controller.isProcessing.value
              ? Text(
                  'Please wait...',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                )
              : Text(
                  'Next',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
        ),
      ),
    );
  }
}
