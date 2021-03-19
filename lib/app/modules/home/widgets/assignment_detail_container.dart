import 'package:get/get.dart';
import 'package:flutter/material.dart';



import 'package:ru_agenda/app/theme/color_theme.dart';
import 'package:ru_agenda/app/data/models/class.model.dart';
import 'package:ru_agenda/app/data/models/assignment.model.dart';
import 'package:ru_agenda/app/widgets/rounded_input_field.widget.dart';
import 'package:ru_agenda/app/modules/home/controllers/home.controller.dart';

class AssignmentDetailContainer extends StatelessWidget {
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
              insetPadding: EdgeInsets.symmetric(horizontal: 15),
              content: Container(
                  height: Get.height * 0.6,
                  width: Get.width,
                  child: _buildDetailAssignment(controller, context)));
        });
  }

  Widget _buildDetailAssignment(
      HomeController controller, BuildContext context) {
    bool isOpenFormEdit = controller.isOpenFormEdit.value;
    controller.assignDescInputController.text = assignment.assignmentDesc;
    controller.assignNameInputController.text = assignment.assignmentName;
    List<int> notificationDays = [1, 2, 3, 4, 5];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            isOpenFormEdit
                ? _buildAssignNameInputField(controller)
                : Container(
                    alignment: Alignment.centerLeft,
                    height: 35,
                    child: Text(
                      assignment.assignmentName,
                      style: TextStyle(
                          color: kPrimaryColor, fontWeight: FontWeight.bold),
                    ),
                  ),
            GestureDetector(
              child: isOpenFormEdit ? Icon(Icons.check) : Icon(Icons.edit),
              onTap: () {
                if (isOpenFormEdit) {
                  controller.saveChangesAssignment(assignment);
                  controller.toggleStatusOpenFormEdit(false);
                } else
                  controller.toggleStatusOpenFormEdit(true);
              },
            ),
          ],
        ),
        SizedBox(height: 20),
        isOpenFormEdit
            ? _buildAttributeAssign(
                title: 'For Class',
                widgetContent: _buildClassDropdown(controller))
            : _buildAttributeAssign(
                title: 'For Class', textContent: assignment.className),
        SizedBox(height: 20),
        isOpenFormEdit
            ? _buildAttributeAssign(
                title: 'Due Date',
                widgetContent: _buildDatePicker(controller, context))
            : _buildAttributeAssign(
                title: 'Due Date', textContent: assignment.getDate()),
        SizedBox(height: 20),
        isOpenFormEdit
            ? _buildAttributeAssign(
                title: 'Notification',
                widgetContent:
                    _buildNoticeDropdown(notificationDays, controller))
            : _buildAttributeAssign(
                title: 'Notification',
                textContent: '${assignment.numberNoticeDay}'),
        SizedBox(height: 20),
        isOpenFormEdit
            ? _buildAttributeAssign(
                title: 'Description',
                widgetContent: _buildAssignDescInputField(controller),
              )
            : _buildAttributeAssign(
                title: 'Description', textContent: assignment.assignmentDesc),
      ],
    );
  }

  SizedBox _buildAssignDescInputField(HomeController controller) {
    return SizedBox(
                height: 150,
                width: Get.width,
                child: RoundedInputField(
                  borderRadius: BorderRadius.circular(10),
                  maxLines: 9,
                  controller: controller.assignDescInputController,
                ),
              );
  }

  Widget _buildAttributeAssign(
      {String title, String textContent, Widget widgetContent}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(
                color: textPrimaryColor, fontWeight: FontWeight.bold)),
        if (textContent != null)
          Container(
            alignment: title != 'Description' ? Alignment.centerLeft : Alignment.topLeft,
            height: title != 'Description' ? 35 : 150,
            child: Text(
              textContent,
              style: TextStyle(color: textPrimaryColor),
              maxLines: 9,
            ),
          ),
        if (widgetContent != null) widgetContent
      ],
    );
  }

  Widget _buildDatePicker(HomeController controller, BuildContext context) {
    return GestureDetector(
      child: _buildRoundedContainer(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('${assignment.getDate()}'),
          Icon(Icons.date_range_rounded),
        ],
      )),
      onTap: () {
        controller.selectDate(context, assignment);
      },
    );
  }

  Widget _buildNoticeDropdown(
      List<int> notificationDays, HomeController controller) {
    return _buildRoundedContainer(
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          hint: Text('Choose your option'),
          value: notificationDays
              .singleWhere((_) => _ == assignment.numberNoticeDay),
          items: notificationDays.map((int value) {
            return DropdownMenuItem(
                value: value,
                child: value == 1 ? Text('$value day') : Text('$value days'));
          }).toList(),
          onChanged: (value) {
            controller.updateNoticeAssignment(assignment, value);
          },
        ),
      ),
    );
  }

  Widget _buildClassDropdown(HomeController controller) {
    return _buildRoundedContainer(
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          hint: Text('Choose your option'),
          value: controller.getCourseTitle(assignment.className),
          items: controller.classes.map((ClassModel value) {
            return DropdownMenuItem(
                value: value.courseTitle, child: Text(value.courseTitle));
          }).toList(),
          onChanged: (value) {
            controller.updateClassAssignment(assignment, value);
          },
        ),
      ),
    );
  }

  Widget _buildAssignNameInputField(HomeController controller) {
    return SizedBox(
      height: 35,
      width: 250,
      child: RoundedInputField(
        borderRadius: BorderRadius.circular(10),
        maxLines: 1,
        controller: controller.assignNameInputController,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildRoundedContainer({Widget child}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 35,
      width: 250,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: Colors.black, width: 1, style: BorderStyle.solid)),
      child: child,
    );
  }
}
