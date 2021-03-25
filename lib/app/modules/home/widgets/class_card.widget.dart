import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:ru_agenda/app/theme/color_theme.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ru_agenda/app/data/models/class.model.dart';
import 'package:ru_agenda/app/modules/home/controllers/home.controller.dart';
import 'package:ru_agenda/app/modules/home/widgets/custom_dialog.widget.dart';
import 'package:ru_agenda/app/modules/home/widgets/dialog_button.widget.dart';

class ClassCard extends StatelessWidget {
  const ClassCard({
    Key key,
    this.classModel,
  }) : super(key: key);

  final ClassModel classModel;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: Get.find(),
      builder: (controller) {
        return GestureDetector(
          onTap: () {
            controller.checkShowAssignsInClass(classModel);
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 15, right: 15, left: 15),
            child: Slidable(
              actionPane: SlidableDrawerActionPane(),
              secondaryActions: [
                IconSlideAction(
                  caption: 'Remove',
                  color: kSecondColor,
                  icon: Icons.delete,
                  onTap: () {
                    Get.dialog(
                      CustomDialog(
                        title: 'Confirmation',
                        content: 'Are you sure you want to remove this class?',
                        actions: [
                          DialogButton(
                            text: 'Remove',
                            onPressed: () {
                              controller.removeClass(classModel);
                              Get.back();
                            },
                          ),
                          DialogButton(
                            text: 'Cancel',
                            onPressed: () {
                              Get.back();
                            },
                          )
                        ],
                      ),
                    );
                  },
                ),
                IconSlideAction(
                  caption: 'Clear',
                  color: Colors.white,
                  icon: Icons.remove_circle_sharp,
                  onTap: () {
                    Get.dialog(CustomDialog(
                        title: 'Confirmation',
                        content:
                            'Are you sure you want to clear data of this class?',
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
                        ]));
                  },
                ),
              ],
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                margin: const EdgeInsets.only(bottom: 0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        classModel.courseTitle,
                        style: TextStyle(
                            color: kPrimaryColor, fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        classModel.isShowingAssignments
                            ? Icons.keyboard_arrow_up_rounded
                            : Icons.keyboard_arrow_down_rounded,
                        color: kPrimaryColor,
                        size: 40,
                      ),
                    ],
                  ),
                ),
                color: Colors.grey[400],
              ),
            ),
          ),
        );
      },
    );
  }
}
