import 'package:sobe/repositories/authentication_repository/authentication_repository.dart';
import 'package:sobe/modules/authentication/signin/cubit/signin_cubit.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:universal_html/html.dart' as html;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sobe/env/env.dart';
import 'dart:io';

void showLoginNeededDialog(BuildContext context) {
  showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      builder: (context) => BlocProvider(
          create: (_) => SignInCubit(
              RepositoryProvider.of<AuthenticationRepository>(context)),
          child: LoginWidget()),
      isScrollControlled: true);
}

class LoginButton extends StatelessWidget {
  LoginButton({this.backgroundColor, this.onTap, this.icon});

  final Color? backgroundColor;
  final VoidCallback? onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        backgroundColor: backgroundColor,
        child: IconButton(
            color: Colors.white, onPressed: onTap, icon: Icon(icon)));
  }
}

class LoginWidget extends StatefulWidget {
  static String routeName = 'login/kakao/web';
  final String reUrl = environment['kakaoUrl']!;
  final String clientId = "5c014310672477f3dd4a2ba19eacc6ad";

  String connect() =>
      "https://kauth.kakao.com/oauth/authorize?client_id=$clientId&redirect_uri=$reUrl&response_type=code";

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  bool _isKakaoTalkInstalled = false;
  bool _isIOS = false;
  late SignInCubit _signInCubit;

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) {
      _initKaKaoTalkInstalled();
      Platform.isIOS == true ? _isIOS = true : false;
    }
    _signInCubit = BlocProvider.of<SignInCubit>(context);
  }

  _initKaKaoTalkInstalled() async {
    final installed = await isKakaoTalkInstalled();
    setState(() {
      _isKakaoTalkInstalled = installed;
    });
  }

  void _loginButtonPressed() {
    _isKakaoTalkInstalled == true ? _loginWithKakaoApp() : _loginWithKakaoWeb();
  }

  void _logoutButtonPressed() async {
    try {
      if (_isKakaoTalkInstalled) {}
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> _loginWithKakaoWeb() async {
    try {
      var authCode = await AuthCodeClient.instance.request();
      print("_loginWithKakaoWeb()" + authCode);
      await _issueAccessToken(authCode);
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> _loginWithKakaoApp() async {
    try {
      var authCode = await AuthCodeClient.instance.requestWithTalk();
      print("_loginWithKakaoApp() " + authCode);
      await _issueAccessToken(authCode);
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> _issueAccessToken(String authCode) async {
    try {
      var token = await AuthApi.instance.issueAccessToken(authCode: authCode);
      DefaultTokenManager().setToken(token);
      User user = await UserApi.instance.me();

      _signInCubit.signInWithSns(
          code: user.id.toString(),
          email: user.kakaoAccount!.email.toString(),
          nickname: user.kakaoAccount!.profile!.nickname.toString(),
          socialType: 'kakao',
          profileImageUrl:
              user.kakaoAccount!.profile!.profileImageUrl.toString());
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> _appleLoginButtonPressed() async {
    final credential = await SignInWithApple.getAppleIDCredential(scopes: [
      AppleIDAuthorizationScopes.email,
      AppleIDAuthorizationScopes.fullName
    ]);

    _signInCubit.signInWithSns(
        code: credential.userIdentifier!,
        email: credential.email!,
        nickname: credential.familyName! + credential.givenName!,
        socialType: 'apple');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 250,
        padding: EdgeInsets.all(5),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Login / Register',
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(color: Colors.black)),
              SizedBox(height: 5),
              Text('로그인이 필요한 서비스입니다.'),
              Text('1분만에 회원가입!'),
              SizedBox(height: 15),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                if (_isIOS == true)
                  LoginButton(
                      backgroundColor: Colors.black,
                      icon: Icons.apple,
                      onTap: () => _appleLoginButtonPressed()),
                if (_isIOS == true) SizedBox(width: 20),
                LoginButton(
                    backgroundColor: Colors.amber,
                    icon: Icons.mode_comment_rounded,
                    onTap: () => kIsWeb
                        ? html.window.location.href = widget.connect()
                        : _loginButtonPressed())
              ])
            ]));
  }
}
