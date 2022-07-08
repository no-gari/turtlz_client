import 'package:turtlz/repositories/authentication_repository/src/authentication_repository.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:turtlz/support/networks/dio_client.dart';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:flutter/material.dart';
import 'package:turtlz/app_view.dart';
import 'package:turtlz/my_app.dart';
import 'package:bloc/bloc.dart';
import 'firebase_options.dart';
import 'package:dio/dio.dart';
import 'bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  AppsflyerSdk appsflyerSdk = AppsflyerSdk(AppsFlyerOptions(
      afDevKey: 'k9PJxiGCC9TFE4humtAzbb', appId: '1632376048'));
  appsflyerSdk.initSdk(
      registerConversionDataCallback: true,
      registerOnAppOpenAttributionCallback: true,
      registerOnDeepLinkingCallback: true);
  appsflyerSdk.onDeepLinking((dp) {
    if (dp.status == Status.FOUND) {
      var path = dp.deepLink!.afSub1;
      var id = dp.deepLink!.afSub2;
      vRouterKey.currentState!.toNamed('/${path}', pathParameters: {'id': id!});
    }
  });
  appsflyerSdk.onInstallConversionData((res) {
    var path = res['payload']['af_sub1'];
    var id = res['payload']['af_sub2'];
    vRouterKey.currentState!.toNamed('/${path}', pathParameters: {'id': id!});
  });
  KakaoSdk.init(nativeAppKey: 'a0c154bbdfaa3783d0e6cb554030e621');
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  OneSignal.shared.setAppId("a6edfa7f-bfa7-4613-b692-0fa3cf72f368");
  OneSignal.shared
      .promptUserForPushNotificationPermission()
      .then((accepted) => print("Accepted permission: $accepted"));
  OneSignal.shared
      .setNotificationOpenedHandler((OSNotificationOpenedResult result) async {
    try {
      var path = await result.notification.additionalData!["path"];
      var id = await result.notification.additionalData!["id"];
      vRouterKey.currentState!.toNamed(path, pathParameters: {'id': id});
    } catch (e, stacktrace) {}
  });

  setPathUrlStrategy();
  Bloc.observer = MyBlocObserver();
  DioClient dioClient = DioClient(Dio());
  runApp(MyApp(
      authenticationRepository: AuthenticationRepository(dioClient),
      dioClient: dioClient));
}
