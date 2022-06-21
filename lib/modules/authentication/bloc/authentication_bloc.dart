import 'package:turtlz/repositories/authentication_repository/src/authentication_repository.dart';
import 'package:turtlz/repositories/user_repository/src/user_repository.dart';
import 'package:turtlz/repositories/user_repository/models/user.dart';
import 'package:turtlz/support/networks/network_exceptions.dart';
import 'package:turtlz/support/networks/api_result.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'dart:async';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
  })  : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(const AuthenticationState.unknown(User.empty)) {
    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) => add(AuthenticationStatusChanged(status)),
    );
  }

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationStatusChanged) {
      yield await _mapAuthenticationStatusChangedToState(event);
    } else if (event is AuthenticationUserChanged) {
      yield await _mapAuthenticationUserChangedToState(event.user);
    } else if (event is AuthenticationLogoutRequested) {
      _authenticationRepository.logOut();
    }
  }

  Future<AuthenticationState> _mapAuthenticationUserChangedToState(
    User user,
  ) async {
    return AuthenticationState.authenticated(user);
  }

  Future<AuthenticationState> _mapAuthenticationStatusChangedToState(
    AuthenticationStatusChanged event,
  ) async {
    switch (event.status) {
      case AuthenticationStatus.authenticated:
        AuthenticationState? status = await _tryGetUser();
        return status!;
      default:
        return const AuthenticationState.unauthenticated();
    }
  }

  Future<AuthenticationState?> _tryGetUser() async {
    try {
      AuthenticationState authenticationState =
          const AuthenticationState.unknown(User.empty);
      ApiResult<User> apiResult = await _userRepository.getUser();
      apiResult.when(success: (User? user) {
        authenticationState = AuthenticationState.authenticated(user!);
      }, failure: (NetworkExceptions? error) {
        authenticationState = AuthenticationState.unauthenticated();
      });
      return authenticationState;
    } on Exception {
      _authenticationRepository.logOut();
    }
  }
}
