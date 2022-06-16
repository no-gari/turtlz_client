import 'package:turtlz/modules/search/search/view/search_page.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  static String routeName = '/search_screen';

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('search.',
                                style: Theme.of(context).textTheme.headline3),
                            IconButton(
                                onPressed: () {},
                                icon: ImageIcon(Svg("assets/icons/noti.svg")))
                          ]),
                      SizedBox(height: 20),
                      SearchPage()
                    ]))));
  }
}
