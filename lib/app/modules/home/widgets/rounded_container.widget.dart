import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoundedContainer extends StatelessWidget {
  const RoundedContainer({
    Key key,
    this.child,
  }) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 48,
      width: Get.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: Colors.black.withOpacity(.5), width: 1, style: BorderStyle.solid)),
      child: child,
    );
  }
}