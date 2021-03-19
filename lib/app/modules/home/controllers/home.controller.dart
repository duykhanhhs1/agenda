import 'package:get/get.dart';
import 'package:flutter/material.dart';


import 'package:ru_agenda/app/data/models/class.model.dart';
import 'package:ru_agenda/app/data/models/assignment.model.dart';
import 'package:ru_agenda/app/data/repositories/class.repository.dart';

class HomeController extends GetxController {
  final ClassRepository repository;
  HomeController({@required this.repository}) : assert(repository != null);

  static HomeController get to => Get.find<HomeController>();

  RxBool isSelectedByDate = RxBool(true);
  RxBool isSelectedByClass = RxBool(false);
  RxBool isSelectedBySchedule = RxBool(false);

  RxBool isOpenFormEdit = RxBool(true);
  TextEditingController assignNameInputController = TextEditingController();
  TextEditingController assignDescInputController = TextEditingController();

  RxList<AssignmentModel> assignments = RxList<AssignmentModel>();
  RxList<ClassModel> classes = RxList<ClassModel>();

  @override
  void onInit() {
    getAssignments();
    getClasses();
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  ///Handle get data API
  void getAssignments() async {
    final List<AssignmentModel> data = await repository.getAssignments();
    assignments = data.obs;

    update();
  }

  void getClasses() async {
    final List<ClassModel> data = await repository.getClasses();
    classes = data.obs;
    update();
  }

  ///Handle selected navigation bar
  void selectOption(String content) {
    if (content == 'By Date') {
      isSelectedByDate.value = true;
      isSelectedByClass.value = false;
      isSelectedBySchedule.value = false;
    }
    if (content == 'By Class') {
      isSelectedByDate.value = false;
      isSelectedByClass.value = true;
      isSelectedBySchedule.value = false;
    }
    if (content == 'By Schedule') {
      isSelectedByDate.value = false;
      isSelectedByClass.value = false;
      isSelectedBySchedule.value = true;
    }
    update();
  }

  ///Show assignments
  void toggleStatusShowAssignsInClass(ClassModel classModel) {
    classModel.isShowingAssignments = !classModel.isShowingAssignments;
    update();
  }

  List<AssignmentModel> getAssignmentsOfClass(int index) {
    return assignments
        .where((_) => _.className == classes[index].courseTitle)
        .toList();
  }


  /// Edit assignment
  void updateClassAssignment(
      AssignmentModel assignment, String className) {
    assignment.className = className;
    update();
  }

  void updateNoticeAssignment(
      AssignmentModel assignment, int number) {
    assignment.numberNoticeDay = number;
    update();
  }

  void selectDate(BuildContext context, AssignmentModel assignment) async {
    DateTime selectedDate = await showDatePicker(
      context: context,
      initialDate: assignment.dueDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (selectedDate != null && selectedDate != assignment.dueDate) {
      assignment.dueDate = selectedDate;
    }
    update();
  }

  String getCourseTitle(String value) {
    if (value != null) {
      ClassModel classModel =
          classes.singleWhere((element) => element.courseTitle == value);
      return classModel.courseTitle;
    }
    return null;
  }

  void toggleStatusOpenFormEdit(bool value) {
    isOpenFormEdit.value = value;
    update();
  }

  void saveChangesAssignment(AssignmentModel assignment){
    assignment.assignmentName = assignNameInputController.text;
    assignment.assignmentDesc = assignDescInputController.text;
    update();
  }


  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
