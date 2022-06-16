import 'package:turtlz/modules/mypage/external_link/external_link.dart';
import 'package:turtlz/support/style/theme.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Widget menuWidget(title) {
  return Stack(children: [
    Container(
        margin:
            EdgeInsets.only(top: theme.textTheme.headline5!.fontSize! / 2 + 2),
        height: 5,
        color: Colors.black,
        width: double.maxFinite),
    Container(
        color: Colors.white,
        child: Text('${title}  '.toUpperCase(),
            style: theme.textTheme.headline5!.copyWith(letterSpacing: -0.5)))
  ]);
}

Widget subMenuWidget({String? title, Function()? tapped}) {
  return ListTile(
      contentPadding: EdgeInsets.all(0),
      dense: true,
      onTap: tapped,
      trailing: Icon(Icons.arrow_forward_ios_rounded, size: Adaptive.dp(15)),
      leading: Text("$title",
          style:
              theme.textTheme.bodyText2!.copyWith(fontSize: Adaptive.dp(14))));
}

Future<dynamic> isWebRouter(BuildContext context, String url) {
  return kIsWeb == false
      ? Navigator.push(
          context, MaterialPageRoute(builder: (_) => ExternalLink(url: url)))
      : launch(url);
}
