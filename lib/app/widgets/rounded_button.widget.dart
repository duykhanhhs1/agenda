import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key key,
    this.width,
    this.height,
    this.color,
    this.textColor,
    this.textContent,
    this.onPressed,
  }) : super(key: key);

  final double width;
  final double height;
  final Color color;
  final Color textColor;
  final String textContent;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: FlatButton(
        onPressed: onPressed,
        child: Text(textContent),
        color: color,
        textColor: textColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }
}
