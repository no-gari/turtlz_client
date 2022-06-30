import 'package:turtlz/modules/authentication/bloc/authentication_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:turtlz/modules/authentication/signin/cubit/signin_cubit.dart';
import 'package:turtlz/repositories/authentication_repository/authentication_repository.dart';
import 'signup_page.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: BlocProvider.of<AuthenticationBloc>(context),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<SignInCubit>(
                create: (_) => SignInCubit(
                    RepositoryProvider.of<AuthenticationRepository>(context))),
          ],
          child: SignupPage(),
        ));
  }
}
