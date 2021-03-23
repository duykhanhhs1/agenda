import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ru_agenda/app/data/models/class.model.dart';
import 'package:ru_agenda/app/modules/home/controllers/home.controller.dart';
import 'package:ru_agenda/app/modules/home/widgets/rounded_container.widget.dart';
import 'package:ru_agenda/app/theme/color_theme.dart';
import 'package:ru_agenda/app/widgets/rounded_input_field.widget.dart';

class FormAddClass extends StatelessWidget {
  const FormAddClass({
    Key key,
    this.classModel,
  }) : super(key: key);

  final ClassModel classModel;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (HomeController controller) {
        return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 15),
          content: SingleChildScrollView(
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        child: Icon(Icons.check),
                        onTap: () {
                          controller.addClass(classModel);
                        },
                      ),
                    ],
                  ),
                  _buildAttributeClass(
                    title: 'Course title',
                    widgetContent: _buildInputFieldClass(
                        controller: controller.courseTitleInputController),
                  ),
                  SizedBox(height: 10),
                  _buildAttributeClass(
                    title: 'Course number',
                    widgetContent: _buildInputFieldClass(
                        controller: controller.courseNumInputController),
                  ),
                  SizedBox(height: 10,width: Get.width,),
                  _buildAttributeClass(
                    title: 'Location',
                    widgetContent: _buildInputFieldClass(
                        controller: controller.locationNameInputController),
                  ),
                  SizedBox(height: 10),
                  _buildAttributeClass(
                    title: 'Date',
                    widgetContent: _buildDatePicker(controller, context),
                  ),
                  SizedBox(height: 10),
                  _buildAttributeClass(
                    title: 'Instructor',
                    widgetContent: _buildInputFieldClass(
                        controller: controller.instructorInputController),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAttributeClass(
      {String title, String textContent, Widget widgetContent}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(
                color: textPrimaryColor, fontWeight: FontWeight.bold)),
        if (textContent != null)
          Container(
            alignment: title != 'Description'
                ? Alignment.centerLeft
                : Alignment.topLeft,
            height: title != 'Description' ? 70 : 150,
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

  Widget _buildInputFieldClass({TextEditingController controller}) {
    return SizedBox(
      height: 60,
      width: Get.width,
      child: RoundedInputField(
        borderRadius: BorderRadius.circular(10),
        maxLines: 1,
        controller: controller,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildDatePicker(HomeController controller, BuildContext context) {
    return GestureDetector(
      child: RoundedContainer(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('${controller.getShortFormatDate(controller.dateMeetSelected)}'),
          Icon(Icons.date_range_rounded),
        ],
      )),
      onTap: () {
        controller.selectDateMeet(context, classModel);
      },
    );
  }
}
