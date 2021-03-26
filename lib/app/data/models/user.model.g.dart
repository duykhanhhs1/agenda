// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    userNo: json['userNo'] as int,
    fullName: json['fullName'] as String,
    email: json['email'] as String,
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'userNo': instance.userNo,
      'fullName': instance.fullName,
      'email': instance.email,
    };

LoginResponseModel _$LoginResponseModelFromJson(Map<String, dynamic> json) {
  return LoginResponseModel(
    token: json['token'] as String,
    refreshToken: json['refreshToken'] as String,
    dateExpired: json['dateExpired'] as String,
    user: json['user'] == null
        ? null
        : UserModel.fromJson(json['user'] as Map<String, dynamic>),
    userNo: json['userNo'] as String,
  );
}

Map<String, dynamic> _$LoginResponseModelToJson(LoginResponseModel instance) =>
    <String, dynamic>{
      'userNo': instance.userNo,
      'token': instance.token,
      'refreshToken': instance.refreshToken,
      'dateExpired': instance.dateExpired,
      'user': instance.user,
    };
