import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sobe/modules/notification/notification_detail/cubit/notification_detail_cubit.dart';
import 'package:sobe/modules/notification/notification_detail/view/notification_detail_page.dart';
import 'package:sobe/repositories/notification_repository/src/notification_repository.dart';
import 'package:vrouter/vrouter.dart';

class NotificationDetailScreen extends StatefulWidget {
  static String routeName = '/notification_detail_screen';

  @override
  _NotificationDetailScreenState createState() =>
      _NotificationDetailScreenState();
}

class _NotificationDetailScreenState extends State<NotificationDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final id = context.vRouter.pathParameters['id'];

    return BlocProvider(
        create: (_) => NotificationDetailCubit(
            RepositoryProvider.of<NotificationRepository>(context)),
        child: NotificationDetailPage(id: int.parse(id!)));
  }
}
