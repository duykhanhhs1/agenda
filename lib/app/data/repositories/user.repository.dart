import 'package:flutter/material.dart';
import 'package:ru_agenda/app/data/models/user.model.dart';
import 'package:ru_agenda/app/data/providers/user.provider.dart';

class UserRepository {
  final UserProvider apiClient;

  UserRepository({@required this.apiClient})
      : assert(apiClient != null);

  Future<LoginResponseModel> verifyUser({String username, String password}) {
    return apiClient.verifyUser(username: username,password: password);
  }

}