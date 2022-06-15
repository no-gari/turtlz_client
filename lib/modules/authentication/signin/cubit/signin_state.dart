part of 'signin_cubit.dart';

class SignInState extends Equatable {
  const SignInState({this.auth, this.error, this.errorMessage});

  final bool? auth;
  final NetworkExceptions? error;
  final String? errorMessage;

  SignInState copyWith({
    bool? auth,
    NetworkExceptions? error,
    String? errorMessage,
  }) {
    return SignInState(
        auth: auth ?? this.auth,
        error: error ?? this.error,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props => [auth, error, errorMessage];
}
