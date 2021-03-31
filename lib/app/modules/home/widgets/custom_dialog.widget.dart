import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ru_agenda/app/data/models/class.model.dart';
import 'package:ru_agenda/app/modules/home/controllers/home.controller.dart';
import 'package:ru_agenda/app/modules/home/widgets/dialog_button.widget.dart';
import 'package:ru_agenda/app/modules/login/controllers/auth.controller.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    Key key,
    this.content,
    this.title,
    this.controller,
    this.actions,
  }) : super(key: key);

  final String content;
  final String title;
  final HomeController controller;
  final List<Widget> actions;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: actions,
    );
  }
}

class ConfirmClearDialog extends StatelessWidget {
  const ConfirmClearDialog({
    Key key,
    @required this.classModel,
    this.controller,
  }) : super(key: key);

  final ClassModel classModel;
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
        title: 'Confirmation',
        content: 'Are you sure you want to clear data of this class?',
        actions: [
          DialogButton(
              text: 'Clear',
              onPressed: () {
                controller.clearDataOfClass(classModel);
                Get.back();
              }),
          DialogButton(
              text: 'Cancel',
              onPressed: () {
                Get.back();
              })
        ]);
  }
}

class ConfirmRemoveDialog extends StatelessWidget {
  const ConfirmRemoveDialog({
    Key key,
    this.content,
    this.onPressed,
  }) : super(key: key);

  final String content;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: 'Confirmation',
      content: content,
      actions: [
        DialogButton(text: 'Remove', onPressed: onPressed),
        DialogButton(
          text: 'Cancel',
          onPressed: () {
            Get.back();
          },
        )
      ],
    );
  }
}

class ConfirmLogoutDialog extends GetView<AuthController> {
  const ConfirmLogoutDialog({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
        title: 'Confirmation',
        content: 'Are you sure you want to log out ?',
        actions: [
          DialogButton(
              text: 'Log out',
              onPressed: () {
                controller.logout();
              }),
          DialogButton(
              text: 'Cancel',
              onPressed: () {
                Get.back();
              }),
        ]);
  }
}

class ConfirmResetDialog extends StatelessWidget {
  const ConfirmResetDialog({
    Key key,
    this.controller,
  }) : super(key: key);
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
        title: 'Confirmation',
        content:
            'Are you sure you want to reset list of classes and list of assignments?',
        actions: [
          DialogButton(
              text: 'Reset',
              onPressed: () {
                controller.resetAll();
                Get.back();
              }),
          DialogButton(
              text: 'Cancel',
              onPressed: () {
                Get.back();
              }),
        ]);
  }
}
