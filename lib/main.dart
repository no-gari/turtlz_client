import 'package:sobe/repositories/authentication_repository/src/authentication_repository.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:sobe/support/networks/dio_client.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_core/firebase_core.dart';
import 'package:amplitude_flutter/amplitude.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sobe/my_app.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'bloc_observer.dart';

void main() async {
  setPathUrlStrategy();
  await firebaseInit();
  await amplitudeInit();
  Bloc.observer = MyBlocObserver();
  DioClient dioClient = DioClient(Dio());
  runApp(MyApp(
      authenticationRepository: AuthenticationRepository(dioClient),
      dioClient: dioClient));
}

Future firebaseInit() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyD8GamJ6XqqsNm4SUCOkajPOVEXayiKymc",
            authDomain: "ustain-bafc6.firebaseapp.com",
            projectId: "ustain-bafc6",
            storageBucket: "ustain-bafc6.appspot.com",
            messagingSenderId: "1097012875305",
            appId: "1:1097012875305:web:e6428ee43c5fcb9c9bcc38",
            measurementId: "G-HHS460QPEW"));
  } else {
    await Firebase.initializeApp();
    KakaoSdk.init(nativeAppKey: '0fd9b9360001091b6dcb391daf4f99ab');
  }
}

Future amplitudeInit() async {
  final Amplitude analytics =
      Amplitude.getInstance(instanceName: "aroundus-ustain");
  await analytics.init('e529d03be979b0a303052c6440bb3d02');
  await analytics.enableCoppaControl();
  await analytics.trackingSessionEvents(true);
}
