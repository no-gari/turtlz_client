import 'package:turtlz/modules/home/components/carousel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:turtlz/modules/home/view/category_page.dart';

class CarouselPage extends StatefulWidget {
  const CarouselPage({Key? key}) : super(key: key);

  @override
  _CarouselPageState createState() => _CarouselPageState();
}

class _CarouselPageState extends State<CarouselPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        options: CarouselOptions(
            viewportFraction: 1,
            autoPlay: false,
            enlargeCenterPage: false,
            scrollDirection: Axis.vertical,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            }),
        items: [for (var item in imagesList) CategoryPage()]);
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
