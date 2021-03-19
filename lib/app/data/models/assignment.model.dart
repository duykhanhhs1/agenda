import 'package:json_annotation/json_annotation.dart';

part 'assignment.model.g.dart';

@JsonSerializable()
class AssignmentModel {
  final int assignmentNo;
  String assignmentName;
  String assignmentDesc;
  DateTime dueDate;
  String className;
  int numberNoticeDay;

  AssignmentModel({
    this.assignmentDesc,
    this.assignmentNo,
    this.assignmentName,
    this.dueDate,
    this.className,
    this.numberNoticeDay,
  });

  String getDate() => dueDate.toString();

  factory AssignmentModel.fromJson(Map<String, dynamic> json) =>
      _$AssignmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$AssignmentModelToJson(this);
}
