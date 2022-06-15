import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class StoreScreen extends StatefulWidget {
  static String routeName = '/store_screen';

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => StoreScreen());
  }

  @override
  State<StoreScreen> createState() => _StoreScreen();
}

class _StoreScreen extends State<StoreScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('store'));
  }
}
