// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssignmentModel _$AssignmentModelFromJson(Map<String, dynamic> json) {
  return AssignmentModel(
    assignmentDesc: json['assignmentDesc'] as String,
    assignmentNo: json['assignmentNo'] as int,
    assignmentName: json['assignmentName'] as String,
    dueDate: json['dueDate'] == null
        ? null
        : DateTime.parse(json['dueDate'] as String),
    className: json['className'] as String,
    numberNoticeDay: json['numberNoticeDay'] as int,
  );
}

Map<String, dynamic> _$AssignmentModelToJson(AssignmentModel instance) =>
    <String, dynamic>{
      'assignmentNo': instance.assignmentNo,
      'assignmentName': instance.assignmentName,
      'assignmentDesc': instance.assignmentDesc,
      'dueDate': instance.dueDate?.toIso8601String(),
      'className': instance.className,
      'numberNoticeDay': instance.numberNoticeDay,
    };
