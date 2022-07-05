import 'package:turtlz/repositories/authentication_repository/src/authentication_repository.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:turtlz/support/networks/dio_client.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:flutter/material.dart';
import 'package:turtlz/my_app.dart';
import 'package:bloc/bloc.dart';
import 'firebase_options.dart';
import 'package:dio/dio.dart';
import 'bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  KakaoSdk.init(nativeAppKey: 'a0c154bbdfaa3783d0e6cb554030e621');
  setPathUrlStrategy();
  Bloc.observer = MyBlocObserver();
  DioClient dioClient = DioClient(Dio());
  runApp(MyApp(
      authenticationRepository: AuthenticationRepository(dioClient),
      dioClient: dioClient));
}
