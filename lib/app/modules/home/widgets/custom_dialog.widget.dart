import 'package:flutter/material.dart';


import 'package:ru_agenda/app/modules/home/controllers/home.controller.dart';
import 'package:ru_agenda/app/modules/home/widgets/dialog_button.widget.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    Key key,
    this.content,
    this.title,
    this.controller, this.actions,
  }) : super(key: key);

  final String content;
  final String title;
  final HomeController controller;
  final List<Widget> actions;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(
          content),
      actions: actions,
    );
  }
}