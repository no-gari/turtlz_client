import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:turtlz/modules/notification/view/notification_screen.dart';
import 'package:extended_tabs/extended_tabs.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';
import 'dart:math' as math;

class MenuPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<MenuPage> {
  PageController _pageController = PageController(initialPage: 0);

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SafeArea(
            child: DefaultTabController(
                length: 2,
                child: NestedScrollView(
                    headerSliverBuilder: (context, innerBoxIsScrolled) {
                      return [
                        storeAppBarWidget(),
                        SliverOverlapAbsorber(
                            handle:
                                NestedScrollView.sliverOverlapAbsorberHandleFor(
                                    context),
                            sliver: SliverPersistentHeader(
                                pinned: true, delegate: TabBarDelegate()))
                      ];
                    },
                    body: storeMenuTabbarWidget()))));
  }

  // 카테고리, 브랜드 분기하는 탭바 부분
  Column storeMenuTabbarWidget() {
    return Column(children: [
      SizedBox(height: 48),
      Expanded(
          child: TabBarView(children: [
        SingleChildScrollView(child: Column(children: [])),
        Container()
      ]))
    ]);
  }
}

// 스토어 최상단 부분 (store, 검색)
class storeAppBarWidget extends StatelessWidget {
  const storeAppBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        expandedHeight: 68,
        brightness: Brightness.light,
        centerTitle: false,
        pinned: false,
        floating: true,
        snap: false,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        flexibleSpace: FlexibleSpaceBar(
            background: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: RichText(
                        text: TextSpan(children: [
                      WidgetSpan(child: Container(height: 20)),
                      WidgetSpan(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                            Text('category.',
                                style: Theme.of(context).textTheme.headline3),
                            IconButton(
                                onPressed: () {},
                                icon: ImageIcon(Svg("assets/icons/noti.svg")))
                          ]))
                    ]))))));
  }
}

class TabBarDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
        child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
                padding: EdgeInsets.only(left: 20, top: 20),
                child: TabBar(
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    labelStyle: Theme.of(context).textTheme.headline5,
                    isScrollable: true,
                    tabs: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Text('products')),
                      Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Text('brands'))
                    ],
                    indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(width: 2.0, color: Colors.black),
                        insets: EdgeInsets.only(bottom: -6)),
                    labelPadding: EdgeInsets.zero,
                    indicatorPadding: EdgeInsets.only(right: 20)))));
  }

  @override
  double get maxExtent => 48;

  @override
  double get minExtent => 48;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
