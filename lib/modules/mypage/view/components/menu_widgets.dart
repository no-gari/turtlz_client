import 'package:turtlz/modules/mypage/external_link/external_link.dart';
import 'package:turtlz/support/style/theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Widget menuWidget(title) {
  return Text('${title}'.toLowerCase(),
      style: theme.textTheme.headline4!
          .copyWith(letterSpacing: -0.5, color: theme.primaryColor));
}

Widget subMenuWidget({String? title, Function()? tapped}) {
  return ListTile(
      contentPadding: EdgeInsets.all(0),
      dense: true,
      onTap: tapped,
      trailing: Icon(Icons.arrow_forward_ios_rounded, size: 15),
      leading: Text("$title", style: theme.textTheme.headline5));
}

Future<dynamic> isWebRouter(BuildContext context, String url) {
  return kIsWeb == false
      ? Navigator.push(
          context, MaterialPageRoute(builder: (_) => ExternalLink(url: url)))
      : launch(url);
}
