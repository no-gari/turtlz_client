import 'package:flutter/material.dart';

class VideoContainer extends StatelessWidget {
  final String? title;
  final String? img;

  VideoContainer({this.title, this.img});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5.0,
        shadowColor: Colors.grey.shade100,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            child: Stack(fit: StackFit.expand, children: <Widget>[
              Image.network(img!, fit: BoxFit.cover, width: double.infinity),
              Column(
                children: [
                  Row(
                    children: [CircleAvatar(), Text('hihihi')],
                  )
                ],
              )
              // Center(
              //     child: Text(title!,
              //         style: TextStyle(
              //             fontSize: 24.0,
              //             fontWeight: FontWeight.bold,
              //             backgroundColor: Colors.black45,
              //             color: Colors.white)))
            ])));
  }
}
