import 'package:flutter/material.dart';

class CarouselWidget extends StatelessWidget {
  final String? title;
  final String? img;

  CarouselWidget({this.title, this.img});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 400,
        color: Colors.black,
        child: Stack(children: <Widget>[
          Image.network(img!, fit: BoxFit.cover, width: double.infinity),
          Center(
              child: Text(title!,
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      backgroundColor: Colors.black45,
                      color: Colors.white)))
        ]));
  }
}
