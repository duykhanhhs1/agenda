import 'package:get/get.dart';


import 'package:ru_agenda/app/data/mock/app.mock.dart';
import 'package:ru_agenda/app/data/models/assignment.model.dart';
import 'package:ru_agenda/app/data/models/class.model.dart';

class ClassProvider extends GetConnect {
  Future<List<ClassModel>> getClasses() async {
    return AppMock.classes;
  }
  Future<List<AssignmentModel>> getAssignments() async {
    return AppMock.assignments;
  }
}