import 'package:json_annotation/json_annotation.dart';
import 'package:intl/intl.dart';

import 'package:ru_agenda/app/data/models/assignment.model.dart';

part 'class.model.g.dart';

@JsonSerializable()
class ClassModel {
  final int classNo;
  String courseTitle;
  int courseNumber;
  String location;
  DateTime dateMeet;
  String instructorName;
  List<AssignmentModel> assignments;
  @JsonKey(ignore: true)
  bool isShowingAssignments;

  ClassModel({
    this.classNo,
    this.courseTitle,
    this.courseNumber,
    this.location,
    dateMeet,
    this.instructorName,
    this.assignments,
    bool isShowingAssignments,
  })  : isShowingAssignments = isShowingAssignments ?? false,
        dateMeet = dateMeet ?? DateTime.now();

  String getLongFormatDate() =>
      DateFormat('EEEE, MMMM d, h:mm a').format(dateMeet);

  String getShortFormatDate() => DateFormat('dd-MM-y').format(dateMeet);

  factory ClassModel.fromJson(Map<String, dynamic> json) =>
      _$ClassModelFromJson(json);

  Map<String, dynamic> toJson() => _$ClassModelToJson(this);
}
