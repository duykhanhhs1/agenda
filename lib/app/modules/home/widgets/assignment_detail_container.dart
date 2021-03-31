import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'package:ru_agenda/app/theme/color_theme.dart';
import 'package:ru_agenda/app/data/models/class.model.dart';
import 'package:ru_agenda/app/data/models/assignment.model.dart';
import 'package:ru_agenda/app/widgets/rounded_input_field.widget.dart';
import 'package:ru_agenda/app/modules/home/controllers/home.controller.dart';
import 'package:ru_agenda/app/modules/home/widgets/custom_dialog.widget.dart';
import 'package:ru_agenda/app/modules/home/widgets/dialog_button.widget.dart';
import 'package:ru_agenda/app/modules/home/widgets/rounded_container.widget.dart';

class AssignmentDetailContainer extends GetView<HomeController> {
  const AssignmentDetailContainer({
    Key key,
    this.assignment,
  }) : super(key: key);

  final AssignmentModel assignment;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: Get.find(),
        builder: (HomeController controller) {
          return AlertDialog(
              insetPadding: const EdgeInsets.symmetric(horizontal: 15),
              content: _buildDetailAssignment(controller, context));
        });
  }

  Widget _buildDetailAssignment(
      HomeController controller, BuildContext context) {
    bool isOpenFormEdit = controller.isOpenFormEdit.value;
    return SingleChildScrollView(
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10),
            isOpenFormEdit
                ? _buildAssignNameInputField(controller)
                : _buildContentField(
                    height: 45,
                    text: assignment.assignmentName,
                    style: TextStyle(
                        color: kPrimaryColor, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            _buildFieldOfAssign(
                title: 'For Class',
                child: isOpenFormEdit
                    ? _buildClassDropdown(controller)
                    : _buildContentField(
                        text: assignment.className, height: 45)),
            SizedBox(height: 10),
            _buildFieldOfAssign(
                title: 'Due Date',
                child: isOpenFormEdit
                    ? _buildDatePicker(controller, context)
                    : _buildContentField(
                        text: assignment.getLongFormatDate(), height: 45)),
            SizedBox(height: 10),
            _buildFieldOfAssign(
                title: 'Notification',
                child: isOpenFormEdit
                    ? _buildNoticeDropdown(controller)
                    : _buildContentField(
                        text: '${assignment.numberNoticeDay}', height: 45)),
            SizedBox(height: 10),
            _buildFieldOfAssign(
                title: 'Description',
                child: isOpenFormEdit
                    ? _buildAssignDescInputField(controller)
                    : _buildContentField(
                        text: assignment.assignmentDesc,
                        alignment: Alignment.topLeft,
                        width: Get.width,
                        maxLines: 15)),
            SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[_buildActions(controller, isOpenFormEdit)],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentField(
      {Alignment alignment = Alignment.centerLeft,
      double width = 260,
      double height,
      String text,
      int maxLines = 2,
      TextStyle style = const TextStyle(color: textPrimaryColor)}) {
    return Container(
      alignment: alignment,
      width: width,
      height: height,
      child: Text(text,
          style: style, maxLines: maxLines, overflow: TextOverflow.ellipsis),
    );
  }

  Widget _buildFieldOfAssign({String title, Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(
                color: textPrimaryColor, fontWeight: FontWeight.bold)),
        child,
      ],
    );
  }

  Widget _buildAssignDescInputField(HomeController controller) {
    return SizedBox(
      width: Get.width,
      child: RoundedInputField(
        keyboardType: TextInputType.text,
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        borderRadius: BorderRadius.circular(10),
        controller: controller.assignDescInputController,
      ),
    );
  }

  Widget _buildDatePicker(HomeController controller, BuildContext context) {
    return GestureDetector(
      child: RoundedContainer(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          controller.isOpenFormEdit.value
              ? Text('${controller.getShortFormatDate()}')
              : Text('${controller.getLongFormatDate()}'),
          Icon(Icons.date_range_rounded),
        ],
      )),
      onTap: () {
        controller.selectDate(context, assignment);
      },
    );
  }

  Widget _buildNoticeDropdown(HomeController controller) {
    return RoundedContainer(
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          hint: Text('Choose your option'),
          value: controller.getNoticeDaysDropdown(),
          items: controller.notificationDays.map((int value) {
            return DropdownMenuItem(
                value: value,
                child: value == 1 ? Text('$value day') : Text('$value days'));
          }).toList(),
          onChanged: (value) {
            controller.updateNoticeSelected(value);
          },
        ),
      ),
    );
  }

  Widget _buildClassDropdown(HomeController controller) {
    return RoundedContainer(
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          hint: Text('Choose your option'),
          value: controller.getCourseTitleDropdown(),
          items: controller.classes.map((ClassModel value) {
            return DropdownMenuItem(
                value: value.courseTitle, child: Text(value.courseTitle));
          }).toList(),
          onChanged: (classNameSelected) {
            controller.updateClassSelected(classNameSelected);
          },
        ),
      ),
    );
  }

  Widget _buildAssignNameInputField(HomeController controller) {
    return RoundedInputField(
      validator: MultiValidator([
        MaxLengthValidator(30, errorText: 'Maximum is 30 characters'),
        MinLengthValidator(6, errorText: 'Minimum is 6 characters'),
      ]),
      hintText: 'Enter assignment name',
      borderRadius: BorderRadius.circular(10),
      maxLines: 1,
      controller: controller.assignNameInputController,
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildActions(HomeController controller, bool isOpenFormEdit) {
    return Row(
      children: [
        if (!isOpenFormEdit)
          DialogButton(
            text: 'Remove',
            onPressed: () {
              Get.dialog(ConfirmRemoveDialog(
                content: 'Are you sure you want to remove this assignment?',
                onPressed: () {
                  controller.removeAssignment(assignment);
                  Get.back();
                },
              ));
            },
          ),
        SizedBox(width: 10),
        DialogButton(
          text: isOpenFormEdit ? 'Done' : 'Edit',
          onPressed: () {
            if (isOpenFormEdit) {
              controller.saveChangesAssignment(assignment);
            } else {
              controller.setOpenFormEdit(true);
              controller.setDefaultValueAssignment(assignment);
            }
          },
        ),
      ],
    );
  }
}
