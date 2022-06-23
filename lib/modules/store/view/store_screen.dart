import 'package:turtlz/repositories/notification_repository/src/notification_repository.dart';
import 'package:turtlz/repositories/store_repository/src/store_repository.dart';
import 'package:turtlz/modules/authentication/bloc/authentication_bloc.dart';
import 'package:turtlz/modules/notification/cubit/notification_cubit.dart';
import 'package:turtlz/modules/store/cubit/store_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'store_page.dart';

class StoreScreen extends StatefulWidget {
  static String routeName = '/store_screen';

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => StoreScreen());
  }

  @override
  State<StoreScreen> createState() => _StoreScreen();
}

class _StoreScreen extends State<StoreScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: BlocProvider.of<AuthenticationBloc>(context),
        child: MultiBlocProvider(providers: [
          BlocProvider<NotificationCubit>(
              create: (_) => NotificationCubit(
                  RepositoryProvider.of<NotificationRepository>(context))),
          BlocProvider<StoreCubit>(
              create: (_) =>
                  StoreCubit(RepositoryProvider.of<StoreRepository>(context)))
        ], child: StorePage()));
  }
}
