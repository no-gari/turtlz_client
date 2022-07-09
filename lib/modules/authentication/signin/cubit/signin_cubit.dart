import 'package:turtlz/repositories/authentication_repository/src/authentication_repository.dart';
import 'package:turtlz/support/networks/network_exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turtlz/support/networks/api_result.dart';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'signin_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(this._authenticationRepository) : super(const SignInState());
  AppsflyerSdk appsflyerSdk = AppsflyerSdk(AppsFlyerOptions(
      afDevKey: 'k9PJxiGCC9TFE4humtAzbb', appId: '1632376048'));

  final AuthenticationRepository _authenticationRepository;

  Future<void> signInWithSns(
      {required String code,
      required String email,
      required String nickname,
      String? socialType}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    ApiResult<Map> apiResult = await _authenticationRepository.signInWithSns(
        code: code, email: email, nickname: nickname, socialType: socialType);

    apiResult.when(success: (Map? response) {
      prefs.setString('access', response!['access']);
      prefs.setString('refresh', response['refresh']);
      appsflyerSdk.logEvent(
          'af_complete_registration', {'af_registration_method': socialType});
      appsflyerSdk.logEvent('af_login', {});
      _authenticationRepository.logIn();
      emit(state.copyWith(auth: true, errorMessage: ''));
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(
          error: error,
          errorMessage: NetworkExceptions.getErrorMessage(error!)));
    });
  }

  Future<void> signInWithEmail(
      {required String email, required String password}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    ApiResult<Map> apiResult = await _authenticationRepository.signInWithEmail(
        email: email, password: password);

    apiResult.when(success: (Map? response) {
      prefs.setString('access', response!['access']);
      prefs.setString('refresh', response['refresh']);
      appsflyerSdk.logEvent('af_login', {});
      _authenticationRepository.logIn();
      emit(state.copyWith(auth: true, errorMessage: ''));
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(
          error: error,
          errorMessage: NetworkExceptions.getErrorMessage(error!)));
    });
  }

  Future<void> signUpWithEmail(
      {required String email, required String password}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    ApiResult<Map> apiResult = await _authenticationRepository.signUpWithEmail(
        email: email, password: password);

    apiResult.when(success: (Map? response) {
      prefs.setString('access', response!['access']);
      prefs.setString('refresh', response['refresh']);
      appsflyerSdk.logEvent(
          'af_complete_registration', {'af_registration_method': 'email'});
      appsflyerSdk.logEvent('af_login', {});
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
