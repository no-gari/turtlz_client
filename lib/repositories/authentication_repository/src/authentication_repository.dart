import 'package:turtlz/support/networks/network_exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turtlz/support/networks/api_result.dart';
import 'package:turtlz/support/networks/dio_client.dart';
import 'dart:convert';
import 'dart:async';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final DioClient _dioClient;

  AuthenticationRepository(this._dioClient);

  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));

    String? accessToken = await getAccessToken();

    if (accessToken != null) {
      yield AuthenticationStatus.authenticated;
    } else {
      yield AuthenticationStatus.unauthenticated;
    }
    yield* _controller.stream;
  }

  Future<void> logIn() async {
    _controller.add(AuthenticationStatus.authenticated);
  }

  void logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('access')) {
      await prefs.remove("refresh");
      await prefs.remove("access").whenComplete(() {
        _controller.add(AuthenticationStatus.unauthenticated);
      });
    } else {
      _controller.add(AuthenticationStatus.unauthenticated);
    }
  }

  void signOut() async {
    try {
      _dioClient.delete('/api/v1/user/profile/').whenComplete(() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.remove("refresh");
        await prefs.remove("access").whenComplete(
            () => _controller.add(AuthenticationStatus.unauthenticated));
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<ApiResult<Map>> signInWithSns(
      {required String code,
      required String email,
      required String nickname,
      String? socialType,
      String? profileImageUrl}) async {
    try {
      String body = json.encode({
        "code": code,
        "socialType": socialType,
        "email": email,
        "nickname": nickname,
        "profileImageUrl": profileImageUrl,
      });

      var response =
          await _dioClient.signinPost('/api/v1/user/social_login/', data: body);
      return ApiResult.success(data: response);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<Map>> signInWithEmail(
      {required String email, required String password}) async {
    try {
      String body = json.encode({
        "email": email,
        "password": password,
      });
      var response =
          await _dioClient.signinPost('/api/v1/user/email_login/', data: body);
      return ApiResult.success(data: response);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<Map>> signUpWithEmail(
      {required String email, required String password}) async {
    try {
      String body = json.encode({
        "email": email,
        "password": password,
      });
      var response =
          await _dioClient.signinPost('/api/v1/user/email_signup/', data: body);
      return ApiResult.success(data: response);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<String?> getAccessToken() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString('access');
    } on Exception {
      print(Error);
    }
  }

  Future<ApiResult<Map>> updateUserProfile(
      Map<String, dynamic> updateUserProfile) async {
    try {
      String body = json.encode(updateUserProfile);
      var response = await _dioClient.put('/api/v1/user/profile/', data: body);

      return ApiResult.success(
        data: response,
      );
    } catch (e) {
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
      );
    }
  }

  void dispose() => _controller.close();
}
