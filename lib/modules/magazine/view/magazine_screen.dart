import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class MagazineScreen extends StatefulWidget {
  static String routeName = '/magazine_screen';

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => MagazineScreen());
  }

  @override
  State<MagazineScreen> createState() => _MagazineScreen();
}

class _MagazineScreen extends State<MagazineScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('magazine'));
  }
}
