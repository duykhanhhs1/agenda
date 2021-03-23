import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:ru_agenda/app/theme/color_theme.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ru_agenda/app/data/models/assignment.model.dart';
import 'package:ru_agenda/app/modules/home/controllers/home.controller.dart';

class AssignmentCard extends StatelessWidget {
  const AssignmentCard({
    Key key,
    this.assignment, this.isShowingInClass,
  }) : super(key: key);

  final AssignmentModel assignment;
  final bool isShowingInClass;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: Get.find(),
        builder: (controller) {
          return Padding(
            padding: isShowingInClass
                ? const EdgeInsets.only(bottom: 0.5, left: 0, right: 0)
                : const EdgeInsets.only(top: 15, right: 15, left: 15),
            child: Slidable(
              actionPane: SlidableDrawerActionPane(),
              secondaryActions: [
                Container(
                  width: 40,
                  child: IconSlideAction(
                    caption: 'Remove',
                    color: kSecondColor,
                    icon: Icons.delete,
                  ),
                ),
              ],
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero
                ),
                margin: EdgeInsets.all(0),
                shadowColor: kPrimaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(assignment.assignmentName,
                              style: TextStyle(
                                  color: textPrimaryColor,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(height: 7),
                          Text('Due: ${assignment.getLongFormatDate()}',
                              style: TextStyle(color: textPrimaryColor)),
                          if (!isShowingInClass)
                            Text('In: ${assignment.className}',
                                style: TextStyle(color: textPrimaryColor)),
                        ],
                      ),
                      if (!isShowingInClass)
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.grey,
                        )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
