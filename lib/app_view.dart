import 'modules/authentication/bloc/authentication_bloc.dart';
import 'package:turtlz/support/networks/dio_client.dart';
import 'package:turtlz/modules/main/main_screen.dart';
import 'package:turtlz/support/style/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';
import 'routes.dart';

final GlobalKey<VRouterState> vRouterKey = GlobalKey<VRouterState>();

class AppView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VRouter(
        theme: theme,
        debugShowCheckedModeBanner: false,
        key: vRouterKey,
        mode: VRouterMode.history,
        builder: (context, child) {
          DioClient.authenticationBloc =
              BlocProvider.of<AuthenticationBloc>(context);
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: buildMultiBlocListener(child));
        },
        initialUrl: MainScreen.routeName,
        routes: routes);
  }

  MultiBlocListener buildMultiBlocListener(Widget child) {
    return MultiBlocListener(listeners: [
      BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {})
    ], child: child);
  }
}
