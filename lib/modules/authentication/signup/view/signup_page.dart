import 'package:turtlz/repositories/authentication_repository/authentication_repository.dart';
import 'package:turtlz/modules/authentication/signup/view/signup_screen.dart';
import 'package:turtlz/modules/authentication/signin/cubit/signin_cubit.dart';
import 'package:turtlz/modules/authentication/bloc/authentication_bloc.dart';
import 'package:turtlz/support/style/format_unit.dart';
import 'package:turtlz/modules/main/main_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  late SignInCubit _signInCubit;

  @override
  void initState() {
    super.initState();
    _signInCubit = BlocProvider.of<SignInCubit>(context);
  }

  @override
  void dispose() {
    passwordConfirmController.dispose();
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
        ),
        body: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) async {
            if (state.status == AuthenticationStatus.authenticated) {
              context.vRouter.to(MainScreen.routeName, isReplacement: true);
            }
          },
          child: BlocListener<SignInCubit, SignInState>(
              listener: (context, state) async {
                if (state.errorMessage != null &&
                    state.errorMessage!.length > 0) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("이메일 혹은 비밀번호를 확인해 주세요."),
                  ));
                  context.read<SignInCubit>().errorMsg();
                }
              },
              child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('sign up.',
                            style: Theme.of(context).textTheme.headline3),
                        const SizedBox(height: 30),
                        const Text("이메일"),
                        TextFormField(
                            controller: emailController,
                            autofocus: true,
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor)),
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor)),
                                hintText: '이메일을 입력 해주세요.')),
                        const SizedBox(height: 20),
                        const Text("비밀번호"),
                        TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor)),
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor)),
                                hintText: '비밀번호를 입력 해주세요.')),
                        const SizedBox(height: 20),
                        const Text("비밀번호 확인"),
                        TextFormField(
                            controller: passwordConfirmController,
                            obscureText: true,
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor)),
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor)),
                                hintText: '비밀번호를 확인 해주세요.')),
                        const SizedBox(height: 30),
                        GestureDetector(
                            onTap: () {
                              if (passwordController.text !=
                                  passwordConfirmController.text) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("비밀번호가 서로 일치하지 않습니다.")));
                              } else {
                                if (emailController.text.trim() != '' &&
                                    passwordController.text.trim() != '') {
                                  _signInCubit.signUpWithEmail(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              }
                            },
                            child: Container(
                                width: maxWidth(context),
                                height: 60,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Center(
                                    child: Text("회원가입",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5!
                                            .copyWith(color: Colors.white))))),
                        const SizedBox(height: 30),
                      ]))),
        ));
  }
}
