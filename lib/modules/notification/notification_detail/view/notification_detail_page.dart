import 'package:turtlz/modules/notification/notification_detail/cubit/notification_detail_cubit.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class NotificationDetailPage extends StatefulWidget {
  final int? id;

  NotificationDetailPage({this.id});

  @override
  _NotificationDetailPageState createState() => _NotificationDetailPageState();
}

class _NotificationDetailPageState extends State<NotificationDetailPage> {
  late NotificationDetailCubit _notificationDetailCubit;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _notificationDetailCubit =
        BlocProvider.of<NotificationDetailCubit>(context);
    _notificationDetailCubit.getNotificationDetail(widget.id!);

    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black),
      body: BlocBuilder<NotificationDetailCubit, NotificationDetailState>(
          builder: (context, state) {
        if (state.isLoaded) {
          return WebView(
              initialUrl: state.notificationDetail!.url,
              javascriptMode: JavascriptMode.unrestricted,
              onPageFinished: (finish) {
                setState(() => isLoading = false);
              });
        }
        return const Center(child: CircularProgressIndicator());
      }),
    );
  }
}
