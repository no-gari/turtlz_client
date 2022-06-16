import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class UserProfileInfo extends StatelessWidget {
  const UserProfileInfo(
      {Key? key, required this.context, required this.title, this.onTap})
      : super(key: key);

  final BuildContext context;
  final String title;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: MaterialButton(
            onPressed: onTap,
            child: Center(
                child: Text('$title',
                    style: TextStyle(
                        fontSize: Adaptive.dp(13),
                        fontWeight: FontWeight.w700)))));
  }
}
