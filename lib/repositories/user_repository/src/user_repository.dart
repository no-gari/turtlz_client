import 'package:shared_preferences/shared_preferences.dart';
import 'package:turtlz/repositories/user_repository/models/user.dart';
import 'package:turtlz/support/networks/api_result.dart';
import 'package:turtlz/support/networks/dio_client.dart';

class UserGetFailure implements Exception {}

class UserRepository {
  final DioClient _dioClient;

  UserRepository(this._dioClient);

  Future<ApiResult<User>> getUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      var response = await _dioClient.put('/api/v1/user/profile/',
          data: {'firebaseToken': prefs.get('firebaseToken')});

      return ApiResult.success(
          data: User(
        nickname: response['nickname'],
        profileImage: response['profileImage'],
        points: response['points'],
      ));
    } on Exception {
      throw UserGetFailure();
    }
  }

  Future<ApiResult<User>> updateUser() async {
    try {
      var response = await _dioClient.put('/api/v1/user/profile/', data: {});

      return ApiResult.success(
          data: User(
        nickname: response['nickname'],
        profileImage: response['profileImage'],
        points: response['points'],
      ));
    } on Exception {
      throw UserGetFailure();
    }
  }
}
