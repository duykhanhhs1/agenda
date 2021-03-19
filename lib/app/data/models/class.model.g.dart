// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassModel _$ClassModelFromJson(Map<String, dynamic> json) {
  return ClassModel(
    classNo: json['classNo'] as int,
    courseTitle: json['courseTitle'] as String,
    courseNumber: json['courseNumber'] as int,
    location: json['location'] as String,
    dateMeet: json['dateMeet'] == null
        ? null
        : DateTime.parse(json['dateMeet'] as String),
    instructorName: json['instructorName'] as String,
    assignments: (json['assignments'] as List)
        ?.map((e) => e == null
            ? null
            : AssignmentModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ClassModelToJson(ClassModel instance) =>
    <String, dynamic>{
      'classNo': instance.classNo,
      'courseTitle': instance.courseTitle,
      'courseNumber': instance.courseNumber,
      'location': instance.location,
      'dateMeet': instance.dateMeet?.toIso8601String(),
      'instructorName': instance.instructorName,
      'assignments': instance.assignments,
    };
