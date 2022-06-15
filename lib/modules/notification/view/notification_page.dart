import 'package:flutter/foundation.dart';
import 'package:sobe/modules/notification/cubit/notification_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late NotificationCubit _notificationCubit;

  @override
  void initState() {
    super.initState();
    _notificationCubit = BlocProvider.of<NotificationCubit>(context);
    _notificationCubit.getNotification();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
      if (state.notification != null) {
        return Column(children: [
          for (var noti in state.notification!)
            ListTile(
                leading: const Icon(Icons.notifications),
                title: Text(noti.title!),
                subtitle: Text(noti.subTitle!),
                onTap: () => kIsWeb
                    ? context.vRouter.toExternal(noti.url!)
                    : context.vRouter.toNamed('/notificationDetail',
                        pathParameters: {'id': noti.id.toString()}))
        ]);
      }
      return Center(child: Text('hihi'));
    });
  }
}
