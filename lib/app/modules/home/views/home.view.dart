import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:ru_agenda/app/data/models/class.model.dart';
import 'package:ru_agenda/app/modules/home/widgets/custom_dialog.widget.dart';
import 'package:ru_agenda/app/modules/home/widgets/dialog_button.widget.dart';
import 'package:ru_agenda/app/modules/home/widgets/form_add_class.widget.dart';
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
    return GetBuilder<HomeController>(
        init: Get.find(),
        builder: (HomeController controller) {
          return Scaffold(
            appBar: AppBar(
              title: Text('RU Agenda'),
              centerTitle: true,
              backgroundColor: kSecondColor,
              actions: [_buildResetIcon(controller)],
              leading: _buildBackIcon(),
            ),
            body: Column(
              children: <Widget>[
                Container(
                  color: Colors.grey[400],
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
                  child: _buildNavBar(controller),
                ),
                Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: kPrimaryLightColor,
                  child: _buildAddContainer(controller),
                ),
                if (controller.isSelectedByDate.value)
                  Expanded(
                      child: _buildListAssignment(
                          controller: controller,
                          assignments: controller.assignments,
                          isShowingInClass: false)),
                if (controller.isSelectedByClass.value)
                  Expanded(child: _buildListClass(controller)),
                if (controller.isSelectedBySchedule.value)
                  Expanded(child: _buildListSchedule(controller))
              ],
            ),
          );
        });
  }


  Widget _buildBackIcon() {
    return Center(
        child: GestureDetector(
      onTap: () {
        Get.offAllNamed(Routes.LOGIN);
      },
      child: Icon(Icons.arrow_back_rounded),
    ));
  }

  Widget _buildResetIcon(HomeController controller) {
    return Center(
      child: GestureDetector(
        child: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: kPrimaryLightColor,
            ),
            child: Text(
              'Reset',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: kSecondColor),
            ),
          ),
        ),
        onTap: () {
          _showConfirmResetDialog(controller);
        },
      ),
    );
  }

  Widget _buildAddContainer(HomeController controller) {
    return InkWell(
      onTap: () {
        if (controller.isSelectedByDate.value) {
          controller.clearFieldsAddAssignment();
          Get.dialog(
            AssignmentDetailContainer(assignment: AssignmentModel()),
          );
        } else {
          Get.dialog(
            FormAddClass(
              classModel: ClassModel(),
            ),
          );
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            controller.isSelectedByDate.value
                ? 'Add an assignment'
                : 'Add a class',
            style:
            TextStyle(color: textPrimaryColor, fontWeight: FontWeight.bold),
          ),
          Icon(
            Icons.add,
            size: 40,
            color: Colors.grey,
          )
        ],
      ),
    );
  }

  Future _showConfirmResetDialog(HomeController controller) {
    return Get.dialog(
      CustomDialog(
        title: 'Confirmation',
        content:
            'Are you sure you want to reset list of classes and list of assignments?',
        actions: [
          DialogButton(
            onPressed: () {
              controller.resetAll();
              Get.back();
            },
            text: 'Reset',
          ),
          DialogButton(
            onPressed: () {
              Get.back();
            },
            text: 'Cancel',
          ),
        ],
      ),
    );
  }

  Widget _buildListSchedule(HomeController controller) {
    return ListView.builder(
      itemCount: controller.classes.length,
      itemBuilder: (context, index) {
        return ScheduleCard(
          classModel: controller.classes[index],
        );
      },
    );
  }

  Widget _buildNavBar(HomeController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildOptionNavBar(
            isSelected: controller.isSelectedByDate.value,
            content: 'By Date',
            topLeft: Radius.circular(15),
            bottomLeft: Radius.circular(15),
            onTap: () {
              controller.selectOption('By Date');
            }),
        _buildOptionNavBar(
          isSelected: controller.isSelectedByClass.value,
          content: 'By Class',
          onTap: () {
            controller.selectOption('By Class');
          },
        ),
        _buildOptionNavBar(
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

  Widget _buildListClass(HomeController controller) {
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
                  child: _buildListAssignment(
                      controller: controller,
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

  Widget _buildListAssignment(
      {List<AssignmentModel> assignments,
      bool isShowingInClass,

      HomeController controller}) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: assignments.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            controller.setOpenFormEdit(false);
            Get.dialog(
              AssignmentDetailContainer(
                assignment: assignments[index],
              ),
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

  Widget _buildOptionNavBar({
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
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
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
