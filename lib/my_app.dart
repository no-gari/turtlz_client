import 'package:turtlz/repositories/authentication_repository/src/authentication_repository.dart';
import 'package:turtlz/repositories/notification_repository/src/notification_repository.dart';
import 'package:turtlz/repositories/user_repository/src/user_repository.dart';
import 'modules/authentication/bloc/authentication_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'support/networks/dio_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:turtlz/app_view.dart';

class MyApp extends StatelessWidget {
  const MyApp(
      {required this.authenticationRepository, required this.dioClient});

  final AuthenticationRepository authenticationRepository;
  final DioClient dioClient;

  @override
  Widget build(BuildContext context) {
    final UserRepository userRepository = UserRepository(dioClient);

    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AuthenticationRepository>(
              create: (context) => authenticationRepository),
          RepositoryProvider(create: (context) => UserRepository(dioClient)),
          RepositoryProvider(
              create: (context) => NotificationRepository(dioClient)),
        ],
        child: MultiBlocProvider(providers: [
          BlocProvider<AuthenticationBloc>(
              create: (context) => AuthenticationBloc(
                  authenticationRepository: authenticationRepository,
                  userRepository: userRepository)),
        ], child: AppView()));
  }
}
