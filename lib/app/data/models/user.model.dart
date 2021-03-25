import 'package:json_annotation/json_annotation.dart';

part 'user.model.g.dart';

@JsonSerializable()
class UserModel {
  final int userNo;
  final String fullName;
  final String email;

  UserModel({this.userNo, this.fullName, this.email});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable()
class LoginResponseModel {
  final String userNo;
  final String token;
  final String refreshToken;
  final String dateExpired;
  final UserModel user;

  LoginResponseModel(
      {this.token,
      this.refreshToken,
      this.dateExpired,
      this.user,
      this.userNo});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);
}
