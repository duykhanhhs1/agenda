import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:ru_agenda/app/data/models/class.model.dart';
import 'package:ru_agenda/app/data/models/assignment.model.dart';
import 'package:ru_agenda/app/data/repositories/class.repository.dart';

class HomeController extends GetxController {
  final ClassRepository repository;
  HomeController({@required this.repository}) : assert(repository != null);

  static HomeController get to => Get.find<HomeController>();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxBool isSelectedByDate = RxBool(true);
  RxBool isSelectedByClass = RxBool(false);
  RxBool isSelectedBySchedule = RxBool(false);

  RxBool isOpenFormEdit = RxBool(true);
  TextEditingController assignNameInputController = TextEditingController();
  TextEditingController assignDescInputController = TextEditingController();
  DateTime dueDateSelected = DateTime.now();
  RxString classNameSelected = RxString();
  TextEditingController courseTitleInputController = TextEditingController();
  TextEditingController courseNumInputController = TextEditingController();
  TextEditingController locationNameInputController = TextEditingController();
  TextEditingController instructorInputController = TextEditingController();
  DateTime dateMeetSelected = DateTime.now();

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
  void checkShowAssignsInClass(ClassModel classModel) {
    classModel.isShowingAssignments = !classModel.isShowingAssignments;
    update();
  }

  List<AssignmentModel> getAssignmentsOfClass(int index) {
    return assignments
        .where((_) => _.className == classes[index].courseTitle)
        .toList();
  }

  /// Edit assignment
  void setDefaultValueAssignment(AssignmentModel assignment) {
    classNameSelected.value = assignment.className;
    assignDescInputController.text = assignment.assignmentDesc;
    assignNameInputController.text = assignment.assignmentName;
  }

  void updateClassTitle(AssignmentModel assignment, String className) {
    assignment.className = className;
    update();
  }

  void updateClassTitle1(String className) {
    classNameSelected.value = className;
    update();
  }

  void updateNoticeAssignment(AssignmentModel assignment, int number) {
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

  String getCourseTitle(String classNameSelected) {
    if (classNameSelected != null) {
      ClassModel classModel = classes
          .singleWhere((element) => element.courseTitle == classNameSelected);
      return classModel.courseTitle;
    }
    return null;
  }

  void setOpenFormEdit(bool value) {
    isOpenFormEdit.value = value;
    update();
  }

  ///Add or save changes assignment
  void saveChangesAssignment(AssignmentModel assignment) {
    if (formKey.currentState.validate()) {
      if (assignment.assignmentName == null) assignments.add(assignment);
      assignment.assignmentName = assignNameInputController.text;
      assignment.assignmentDesc = assignDescInputController.text;
      assignment.className = classNameSelected.value;
      setOpenFormEdit(false);
      update();
    }

  }

  void clearFieldsAddAssignment() {
    setOpenFormEdit(true);
    assignNameInputController.clear();
    assignDescInputController.clear();
    update();
  }

  ///Remove assignment
  void removeAssignment(AssignmentModel assignment) {
    assignments.remove(assignment);
    Get.back();
    update();
  }

  ///CLASS
  void selectDateMeet(BuildContext context, ClassModel classModel) async {
    dateMeetSelected = await showDatePicker(
      context: context,
      initialDate: classModel.dateMeet,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    update();
  }

  String getShortFormatDate(DateTime dateTime) =>
      DateFormat('dd-MM-y').format(dateTime);

  void addClass(ClassModel classModel) {
    classModel.courseTitle = courseTitleInputController.text;
    classModel.courseNumber = int.tryParse(courseNumInputController.text);
    classModel.location = locationNameInputController.text;
    classModel.dateMeet = dateMeetSelected;
    classModel.instructorName = instructorInputController.text;
    classes.add(classModel);
    Get.back();
    update();
  }

  ///Reset all data
  void resetAll() {
    assignments.clear();
    classes.clear();
    update();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
