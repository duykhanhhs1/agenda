import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:ru_agenda/app/routes/app_pages.dart';
import 'package:ru_agenda/app/theme/color_theme.dart';
import 'package:ru_agenda/app/data/models/assignment.model.dart';
import 'package:ru_agenda/app/modules/home/widgets/class_card.widget.dart';
import 'package:ru_agenda/app/modules/home/widgets/schedule_card.widget.dart';
import 'package:ru_agenda/app/modules/home/controllers/home.controller.dart';
import 'package:ru_agenda/app/modules/home/widgets/assignment_card.widget.dart';
import 'package:ru_agenda/app/modules/home/widgets/assignment_detail_container.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RU Agenda'),
        centerTitle: true,
        backgroundColor: kSecondColor,
        leading: Center(
            child: GestureDetector(
          onTap: () {
            Get.offAllNamed(Routes.LOGIN);
          },
          child: Icon(Icons.arrow_back_rounded),
        )),
      ),
      body: GetBuilder<HomeController>(
        init: Get.find(),
        builder: (HomeController controller) {
          return Column(
            children: <Widget>[
              Container(
                color: Colors.grey[400],
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
                child: buildNavBar(controller),
              ),
              Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                color: kPrimaryLightColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      controller.isSelectedByDate.value
                          ? 'Add an assignment'
                          : controller.isSelectedByClass.value
                              ? 'Add a class'
                              : 'Add a class',
                      style: TextStyle(
                          color: textPrimaryColor, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      child: Icon(
                        Icons.add,
                        size: 40,
                        color: Colors.grey,
                      ),
                      onTap: () {
                        if (controller.isSelectedByDate.value) {
                          AssignmentModel assignmentAdd = AssignmentModel();
                          controller.toggleStatusOpenFormEdit(true);
                          Get.dialog(
                            AssignmentDetailContainer(
                                assignment: assignmentAdd),
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
              if (controller.isSelectedByDate.value)
                Expanded(
                    child: buildListAssignment(
                        assignments: controller.assignments,
                        isShowingInClass: false)),
              if (controller.isSelectedByClass.value)
                Expanded(child: buildListClass(controller)),
              if (controller.isSelectedBySchedule.value)
                Expanded(child: buildListSchedule(controller))
            ],
          );
        },
      ),
    );
  }

  ListView buildListSchedule(HomeController controller) {
    return ListView.builder(
      itemCount: controller.classes.length,
      itemBuilder: (context, index) {
        return ScheduleCard(
          classModel: controller.classes[index],
        );
      },
    );
  }

  Widget buildNavBar(HomeController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        buildOptionNavBar(
            isSelected: controller.isSelectedByDate.value,
            content: 'By Date',
            topLeft: Radius.circular(15),
            bottomLeft: Radius.circular(15),
            onTap: () {
              controller.selectOption('By Date');
            }),
        buildOptionNavBar(
          isSelected: controller.isSelectedByClass.value,
          content: 'By Class',
          onTap: () {
            controller.selectOption('By Class');
          },
        ),
        buildOptionNavBar(
          isSelected: controller.isSelectedBySchedule.value,
          content: 'By Schedule',
          topRight: Radius.circular(15),
          bottomRight: Radius.circular(15),
          onTap: () {
            controller.selectOption('By Schedule');
          },
        ),
      ],
    );
  }

  Widget buildListClass(HomeController controller) {
    return ListView.builder(
      itemCount: controller.classes.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            ClassCard(
              classModel: controller.classes[index],
            ),
            if (controller.classes[index].isShowingAssignments)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 300),
                  child: buildListAssignment(
                      assignments: controller.getAssignmentsOfClass(index),
                      isShowingInClass:
                          controller.classes[index].isShowingAssignments),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget buildListAssignment(
      {List<AssignmentModel> assignments, bool isShowingInClass}) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: assignments.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Get.dialog(
              AssignmentDetailContainer(
                assignment: assignments[index],
              ),
              barrierDismissible: true,
            );
          },
          child: AssignmentCard(
            assignment: assignments[index],
            isShowingInClass: isShowingInClass,
          ),
        );
      },
    );
  }

  Widget buildOptionNavBar({
    bool isSelected,
    String content,
    Radius topLeft,
    Radius topRight,
    Radius bottomLeft,
    Radius bottomRight,
    Function onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: 120,
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
            color: isSelected ? kSecondColor : kPrimaryLightColor,
            borderRadius: BorderRadius.only(
                topLeft: topLeft != null ? topLeft : Radius.circular(0),
                bottomLeft:
                    bottomLeft != null ? bottomLeft : Radius.circular(0),
                topRight: topRight != null ? topRight : Radius.circular(0),
                bottomRight:
                    bottomRight != null ? bottomRight : Radius.circular(0))),
        child: Text(
          content,
          style:
              TextStyle(color: isSelected ? kPrimaryLightColor : kPrimaryColor),
        ),
      ),
    );
  }
}
