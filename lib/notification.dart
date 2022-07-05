import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:turtlz/app_view.dart';
import 'dart:async';
import 'dart:io';

Future<void> onBackgroundMessage(RemoteMessage message) async {
  // await Firebase.initializeApp();
  if (message.data.containsKey('data')) {
    final data = message.data['data'];
  }
  if (message.data.containsKey('notification')) {
    final notification = message.data['notification'];
  }
}

class FCM {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final streamCtlr = StreamController<String>.broadcast();
  final titleCtlr = StreamController<String>.broadcast();
  final bodyCtlr = StreamController<String>.broadcast();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  AndroidNotificationDetails android = const AndroidNotificationDetails(
      'high_importance_channel', 'High Importance Notifications',
      importance: Importance.max, priority: Priority.max);
  IOSNotificationDetails ios = const IOSNotificationDetails();
  NotificationDetails? detail;

  setNotifications() async {
    // handle ios, android permission settings
    PermissionStatus status = await Permission.notification.request();
    while (status.isDenied) {
      status = await Permission.notification.request();
      await openAppSettings();
    }
    AndroidInitializationSettings initSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    IOSInitializationSettings initSettingsIOS = const IOSInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );
    InitializationSettings initSettings = InitializationSettings(
        android: initSettingsAndroid, iOS: initSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initSettings);
    detail = NotificationDetails(android: android, iOS: ios);
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(const AndroidNotificationChannel(
          'high_importance_channel',
          'High Importance Notifications',
          importance: Importance.high,
        ));
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);

    FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);
    forgroundNotification();
    backgroundNotification();
    terminateNotification();

    final String? token = await _firebaseMessaging.getToken();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('firebaseToken', token!);
    print(token);

    if (Platform.isIOS) {
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }

  forgroundNotification() {
    FirebaseMessaging.onMessage.listen((message) async {
      if (message.data.containsKey('data')) {
        // Handle data message
        streamCtlr.sink.add(message.data['data']);
      }
      if (message.data.containsKey('notification')) {
        // Handle notification message
        streamCtlr.sink.add(message.data['notification']);
      }
      // Or do other work.
      titleCtlr.sink.add(message.notification!.title!);
      bodyCtlr.sink.add(message.notification!.body!);

      if (message.notification != null && Platform.isAndroid) {
        flutterLocalNotificationsPlugin.show(message.notification.hashCode,
            message.notification!.title, message.notification!.body, detail);
      }
    });
  }

  backgroundNotification() {
    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      if (message.data.containsKey('data')) {
        // Handle data message
        streamCtlr.sink.add(message.data['data']);
      }
      if (message.data.containsKey('notification')) {
        // Handle notification message
        streamCtlr.sink.add(message.data['notification']);
      }
      // Or do other work.
      titleCtlr.sink.add(message.notification!.title!);
      bodyCtlr.sink.add(message.notification!.body!);

      String route = message.data["route"].toString();
      String id = message.data["id"].toString();
      vRouterKey.currentState!.toNamed(route, pathParameters: {'id': id});
    });
  }

  terminateNotification() async {
    await FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        if (message.data.containsKey('data')) {
          streamCtlr.sink.add(message.data['data']);
        }
        if (message.data.containsKey('notification')) {
          streamCtlr.sink.add(message.data['notification']);
        }
        String route = message.data["route"].toString();
        String id = message.data["id"].toString();
        vRouterKey.currentState!.toNamed(route, pathParameters: {'id': id});
      }
    });
  }

  dispose() {
    streamCtlr.close();
    bodyCtlr.close();
    titleCtlr.close();
  }

  @override
  Future<void> show(title, body) async =>
      this.flutterLocalNotificationsPlugin.show(1, title, body, detail);
}
