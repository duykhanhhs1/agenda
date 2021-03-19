import 'package:json_annotation/json_annotation.dart';

import 'package:ru_agenda/app/data/models/assignment.model.dart';

part 'class.model.g.dart';

@JsonSerializable()
class ClassModel {
  final int classNo;
  final String courseTitle;
  final int courseNumber;
  final String location;
  final DateTime dateMeet;
  final String instructorName;
   List<AssignmentModel> assignments;
  @JsonKey(ignore: true)
  bool isShowingAssignments;

  ClassModel({
    this.classNo,
    this.courseTitle,
    this.courseNumber,
    this.location,
    this.dateMeet,
    this.instructorName,
    this.assignments,
    bool isShowingAssignments,
  }) : isShowingAssignments = isShowingAssignments ?? false;



  factory ClassModel.fromJson(Map<String, dynamic> json) =>
      _$ClassModelFromJson(json);

  Map<String, dynamic> toJson() => _$ClassModelToJson(this);
}
