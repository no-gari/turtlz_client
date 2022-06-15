import 'package:turtlz/repositories/authentication_repository/src/authentication_repository.dart';
import 'package:turtlz/support/networks/network_exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turtlz/support/networks/api_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'signin_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(this._authenticationRepository) : super(const SignInState());

  final AuthenticationRepository _authenticationRepository;

  Future<void> signInWithSns(
      {required String code,
      required String email,
      required String nickname,
      String? profileImageUrl,
      String? socialType}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    ApiResult<Map> apiResult = await _authenticationRepository.signInWithSns(
        code: code,
        profileImageUrl: profileImageUrl,
        email: email,
        nickname: nickname,
        socialType: socialType);

    apiResult.when(success: (Map? response) {
      prefs.setString('access', response!['access']);
      prefs.setString('refresh', response['refresh']);
      _authenticationRepository.logIn();
      emit(state.copyWith(auth: true, errorMessage: ''));
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(
          error: error,
          errorMessage: NetworkExceptions.getErrorMessage(error!)));
    });
  }

  void errorMsg() {
    emit(state.copyWith(errorMessage: ""));
  }
}
