import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:ru_agenda/app/data/models/class.model.dart';
import 'package:ru_agenda/app/data/models/assignment.model.dart';
import 'package:ru_agenda/app/data/repositories/class.repository.dart';
import 'package:ru_agenda/app/modules/home/widgets/assignment_card.widget.dart';
import 'package:ru_agenda/app/modules/home/widgets/dialog_button.widget.dart';
import 'package:ru_agenda/app/modules/home/widgets/notify_user.widget.dart';

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

  Rx<DateTime> dateSelected = DateTime.now().obs;
  Rx<TimeOfDay> timeSelected = TimeOfDay.now().obs;

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
    sortAssignments();
    checkNotify();
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
      DateFormat('EEEE, MMMM d, h:mm a').format(dateSelected.value);

  String getShortFormatDate() =>
      DateFormat('dd-MM-y, h:mm a').format(dateSelected.value);

  void sortAssignments() {
    assignments.sort((a, b) => a.dueDate.compareTo(b.dueDate));
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
    noticeDaysSelected.value = assignment.numberNoticeDay;
    dateSelected.value = assignment.dueDate;
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
      initialDate: dateSelected.value,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    ).then((value) {
      if (value != null) dateSelected.value = value;
      return dateSelected;
    });
    await showTimePicker(
      context: context,
      initialTime:
          TimeOfDay(hour: timeSelected.value.hour, minute: timeSelected.value.minute),
    ).then((value) {
      if (value != null) timeSelected.value = value;
      return timeSelected;
    });
    dateSelected.value = DateTime(dateSelected.value.year, dateSelected.value.month,
        dateSelected.value.day, timeSelected.value.hour, timeSelected.value.minute);
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
      if (dateSelected.value.isAfter(DateTime.now())) {
        if (assignment.assignmentName == null) assignments.add(assignment);
        assignment.assignmentName = assignNameInputController.text;
        assignment.assignmentDesc = assignDescInputController.text;
        assignment.className = classNameSelected.value;
        assignment.numberNoticeDay = noticeDaysSelected.value;
        assignment.dueDate = dateSelected.value;
        sortAssignments();
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
    dateSelected.value = DateTime.now();
    timeSelected.value = TimeOfDay.now();
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
        dateSelected.value.isAfter(DateTime.now())) {
      classModel.courseTitle = courseTitleInputController.text;
      classModel.courseNumber = int.tryParse(courseNumInputController.text);
      classModel.location = locationInputController.text;
      classModel.dateMeet = dateSelected.value;
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

  ///Check to show notify
  void checkNotify() {
    List<AssignmentModel> notifyAssignments = assignments
        .where((_) => (_.dueDate.isAfter(DateTime.now()) &&
            (_.dueDate.difference(DateTime.now()).inDays <= 2)))
        .toList();
    if (notifyAssignments.length > 0) {
      Get.dialog(NotifyUser(notifyAssignments: notifyAssignments));
    }
  }
}
