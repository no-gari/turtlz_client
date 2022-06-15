import 'package:turtlz/modules/home/components/video_container.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.2), BlendMode.dstIn),
                image: NetworkImage(
                    imagesList[_currentIndex]['image'].toString()))),
        child: CarouselSlider(
            options: CarouselOptions(
                autoPlay: false,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
                height: MediaQuery.of(context).size.height * 0.6,
                onPageChanged: (index, reason) {
                  setState(() => _currentIndex = index);
                }),
            items: [
              for (var item in imagesList)
                VideoContainer(title: item['title'], img: item['image'])
            ]));
  }
}

final List<Map<String, String>> imagesList = [
  {
    'image':
        'https://cdn.pixabay.com/photo/2020/11/01/23/22/breakfast-5705180_1280.jpg',
    'title': 'coffee'
  },
  {
    'image':
        'https://cdn.pixabay.com/photo/2016/11/18/19/00/breads-1836411_1280.jpg',
    'title': 'bread'
  },
  {
    'image':
        'https://cdn.pixabay.com/photo/2019/01/14/17/25/gelato-3932596_1280.jpg',
    'title': 'gelato'
  },
  {
    'image':
        'https://cdn.pixabay.com/photo/2017/04/04/18/07/ice-cream-2202561_1280.jpg',
    'title': 'ice cream'
  }
];
