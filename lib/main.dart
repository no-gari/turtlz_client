import 'package:turtlz/repositories/authentication_repository/src/authentication_repository.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:turtlz/support/networks/dio_client.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_core/firebase_core.dart';
// import 'package:amplitude_flutter/amplitude.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:turtlz/my_app.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  await firebaseInit();
  // await amplitudeInit();
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
            apiKey: "AIzaSyAi2Y06-KOzOPfW9Y4Rd_QxcWTAm2aGi80",
            authDomain: "turtlz.firebaseapp.com",
            projectId: "turtlz",
            storageBucket: "turtlz.appspot.com",
            messagingSenderId: "353560109519",
            appId: "1:353560109519:web:73d67beb9e720c52d9f2ba",
            measurementId: "G-J2FQ5XDEEM"));
  } else {
    await Firebase.initializeApp();
    KakaoSdk.init(nativeAppKey: 'a0c154bbdfaa3783d0e6cb554030e621');
  }
}
//
// Future amplitudeInit() async {
//   final Amplitude analytics =
//       Amplitude.getInstance(instanceName: "aroundus-ustain");
//   await analytics.init('e529d03be979b0a303052c6440bb3d02');
//   await analytics.enableCoppaControl();
//   await analytics.trackingSessionEvents(true);
// }
