import 'package:flutter_svg_provider/flutter_svg_provider.dart' as Svg;
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';

class StorePage extends StatefulWidget {
  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SafeArea(
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  "assets/images/turtlz.svg",
                  width: 120,
                ),
                IconButton(
                    onPressed: () {},
                    icon: ImageIcon(Svg.Svg("assets/icons/noti.svg")))
              ],
            )
          ]),
        ),
      ),
    );
  }
}
