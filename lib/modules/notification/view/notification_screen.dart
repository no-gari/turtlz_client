import 'package:turtlz/repositories/notification_repository/src/notification_repository.dart';
import 'package:turtlz/modules/notification/cubit/notification_cubit.dart';
import 'package:turtlz/modules/notification/view/notification_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  static String routeName = '/notification_screen';

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => NotificationScreen());
  }

  @override
  State<NotificationScreen> createState() => _NotificationScreen();
}

class _NotificationScreen extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => NotificationCubit(
            RepositoryProvider.of<NotificationRepository>(context)),
        child: Scaffold(body: SafeArea(child: NotificationPage())));
  }
}
