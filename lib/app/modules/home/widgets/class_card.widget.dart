import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


import 'package:ru_agenda/app/theme/color_theme.dart';
import 'package:ru_agenda/app/data/models/class.model.dart';
import 'package:ru_agenda/app/modules/home/controllers/home.controller.dart';
import 'package:ru_agenda/app/modules/home/widgets/custom_dialog.widget.dart';

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
              actionExtentRatio: 0.17,
              actionPane: SlidableDrawerActionPane(),
              secondaryActions: [
                IconSlideAction(
                  caption: 'Remove',
                  color: kSecondColor,
                  iconWidget: SizedBox(height: 0),
                  onTap: () {
                    Get.dialog(
                      ConfirmRemoveDialog(
                        content: 'Are you sure you want to remove this class?',
                        onPressed: () {
                          controller.removeClass(classModel);
                          Get.back();
                        },
                      ),
                    );
                  },
                ),
                IconSlideAction(
                  caption: 'Clear',
                  color: Colors.white,
                  iconWidget: SizedBox(height: 0),
                  onTap: () {
                    Get.dialog(ConfirmClearDialog(
                      classModel: classModel,
                      controller: controller,
                    ));
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
