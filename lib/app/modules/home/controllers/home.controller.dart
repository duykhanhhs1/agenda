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

  List<int> notificationDays = [1, 2, 3, 4, 5];

  RxBool isOpenFormEdit = RxBool(true);
  TextEditingController assignNameInputController = TextEditingController();
  TextEditingController assignDescInputController = TextEditingController();
  RxInt noticeDaysSelected = RxInt();

  RxString classNameSelected = RxString();
  TextEditingController courseTitleInputController = TextEditingController();
  TextEditingController courseNumInputController = TextEditingController();
  TextEditingController locationInputController = TextEditingController();
  TextEditingController instructorInputController = TextEditingController();

  DateTime dateSelected = DateTime.now();
  TimeOfDay timeSelected = TimeOfDay.now();

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

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
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

  String getLongFormatDate() =>
      DateFormat('EEEE, MMMM d, h:mm a').format(dateSelected);

  String getShortFormatDate() =>
      DateFormat('dd-MM-y, h:mm a').format(dateSelected);

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
    noticeDaysSelected.value = assignment.numberNoticeDay;
    dateSelected = assignment.dueDate;
  }

  void updateClassSelected(String className) {
    classNameSelected.value = className;
    update();
  }

  void updateNoticeSelected(int value) {
    noticeDaysSelected.value = value;
    update();
  }

  void selectDate(BuildContext context, [AssignmentModel assignment]) async {
    await showDatePicker(
      context: context,
      initialDate: dateSelected,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    ).then((value) {
      if (value != null) dateSelected = value;
      return dateSelected;
    });
    await showTimePicker(
      context: context,
      initialTime:
          TimeOfDay(hour: timeSelected.hour, minute: timeSelected.minute),
    ).then((value) {
      if (value != null) timeSelected = value;
      return timeSelected;
    });
    dateSelected = DateTime(dateSelected.year, dateSelected.month,
        dateSelected.day, timeSelected.hour, timeSelected.minute);
    update();
  }

  String getCourseTitleDropdown() {
    if (classNameSelected.value != null) {
      ClassModel classModel = classes.firstWhere(
          (element) => element.courseTitle == classNameSelected.value);
      return classModel.courseTitle;
    }
    classNameSelected = classes.first.courseTitle.obs;
    return classNameSelected.value;
  }

  int getNoticeDaysDropdown() {
    if (noticeDaysSelected.value != null) {
      return notificationDays
          .firstWhere((element) => element == noticeDaysSelected.value);
    }
    noticeDaysSelected.value = notificationDays.first;
    return noticeDaysSelected.value;
  }

  void setOpenFormEdit(bool value) {
    isOpenFormEdit.value = value;
    update();
  }

  ///Add or save changes assignment
  void saveChangesAssignment(AssignmentModel assignment) {
    if (formKey.currentState.validate()) {
      if (dateSelected.isAfter(DateTime.now())) {
        if (assignment.assignmentName == null) assignments.add(assignment);
        assignment.assignmentName = assignNameInputController.text;
        assignment.assignmentDesc = assignDescInputController.text;
        assignment.className = classNameSelected.value;
        assignment.numberNoticeDay = noticeDaysSelected.value;
        assignment.dueDate = dateSelected;
        setOpenFormEdit(false);
      } else {
        Get.snackbar(
            'Error', 'The due time must be greater than the current time',
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 3),
            colorText: Colors.red,
            backgroundColor: Colors.white.withOpacity(.8));
      }
    }
    update();
  }

  void clearFieldsFormAddInput() {
    setOpenFormEdit(true);
    assignNameInputController.clear();
    assignDescInputController.clear();
    courseTitleInputController.clear();
    courseNumInputController.clear();
    locationInputController.clear();
    instructorInputController.clear();
    dateSelected = DateTime.now();
    timeSelected = TimeOfDay.now();
    update();
  }

  ///Remove assignment
  void removeAssignment(AssignmentModel assignment) {
    assignments.remove(assignment);
    Get.back();
    update();
  }

  ///CLASS
  void addClass(ClassModel classModel) {
    if (formKey.currentState.validate() &&
        dateSelected.isAfter(DateTime.now())) {
      classModel.courseTitle = courseTitleInputController.text;
      classModel.courseNumber = int.tryParse(courseNumInputController.text);
      classModel.location = locationInputController.text;
      classModel.dateMeet = dateSelected;
      classModel.instructorName = instructorInputController.text;
      classes.add(classModel);
      Get.back();
      update();
    } else {
      Get.snackbar(
          'Error', 'The due time must be greater than the current time',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
          colorText: Colors.red,
          backgroundColor: Colors.white.withOpacity(.8));
    }
  }

  void removeClass(ClassModel classModel) {
    classes.remove(classModel);
    update();
  }

  void clearDataOfClass(ClassModel classModel) {
    assignments.removeWhere((_) => _.className == classModel.courseTitle);
    classModel.isShowingAssignments = false;
    update();
  }

  ///Reset all data
  void resetAll() {
    assignments.clear();
    classes.clear();
    update();
  }
}
