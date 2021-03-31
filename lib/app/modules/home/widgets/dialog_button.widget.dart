import 'package:flutter/material.dart';


import 'package:ru_agenda/app/theme/color_theme.dart';


class DialogButton extends StatelessWidget {
  const DialogButton({
    Key key,this.text, this.onPressed,
  }) : super(key: key);

  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      child: Text(text),
      color: kPrimaryColor,
      textColor: kPrimaryLightColor,
    );
  }
}