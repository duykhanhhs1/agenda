import 'package:flutter/material.dart';


import 'package:ru_agenda/app/data/models/assignment.model.dart';
import 'package:ru_agenda/app/data/models/class.model.dart';
import 'package:ru_agenda/app/data/providers/class.provider.dart';

class ClassRepository {
  final ClassProvider apiClient;

  ClassRepository({@required this.apiClient})
      : assert(apiClient != null);

  Future<List<ClassModel>> getClasses() {
    return apiClient.getClasses();
  }

  Future<List<AssignmentModel>> getAssignments() {
    return apiClient.getAssignments();
  }
}