import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:turtlz/modules/notification/view/notification_screen.dart';
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
      const SizedBox(height: 48),
      Expanded(
          child: TabBarView(children: [
        SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: [
              GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.5,
                  children: [
                    Container(height: 100, color: Colors.black),
                    Container(height: 100, color: Colors.black),
                    Container(height: 100, color: Colors.black),
                    Container(height: 100, color: Colors.black),
                  ])
            ])),
        SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: [
              ListTile(
                  contentPadding: EdgeInsets.zero,
                  onTap: () {},
                  leading: Container(
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: CircleAvatar(
                          backgroundColor: Colors.black,
                          // backgroundImage: NetworkImage(this.logo!),
                          radius: 20)),
                  title: Text('브랜드이름',
                      style: Theme.of(context).textTheme.headline5),
                  subtitle: Text('제목',
                      style: Theme.of(context).textTheme.bodyText2,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                  isThreeLine: false),
              ListTile(
                  contentPadding: EdgeInsets.zero,
                  onTap: () {},
                  leading: Container(
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: CircleAvatar(
                          backgroundColor: Colors.black,
                          // backgroundImage: NetworkImage(this.logo!),
                          radius: 20)),
                  title: Text('브랜드이름',
                      style: Theme.of(context).textTheme.headline5),
                  subtitle: Text('제목',
                      style: Theme.of(context).textTheme.bodyText2,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                  isThreeLine: false),
              ListTile(
                  contentPadding: EdgeInsets.zero,
                  onTap: () {},
                  leading: Container(
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: CircleAvatar(
                          backgroundColor: Colors.black,
                          // backgroundImage: NetworkImage(this.logo!),
                          radius: 20)),
                  title: Text('브랜드이름',
                      style: Theme.of(context).textTheme.headline5),
                  subtitle: Text('제목',
                      style: Theme.of(context).textTheme.bodyText2,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                  isThreeLine: false)
            ]))
      ]))
    ]);
  }
}

// 스토어 최상단 부분 (store, 검색)
class storeAppBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
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
    return Align(
        alignment: Alignment.centerLeft,
        child: Container(
            padding: const EdgeInsets.only(left: 20),
            child: TabBar(
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                labelStyle: Theme.of(context).textTheme.headline5,
                isScrollable: true,
                tabs: const [
                  Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Text('products')),
                  Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Text('brands'))
                ],
                indicator: const UnderlineTabIndicator(
                    borderSide: BorderSide(width: 2.0, color: Colors.black),
                    insets: EdgeInsets.only(bottom: -6)),
                labelPadding: EdgeInsets.zero,
                indicatorPadding: const EdgeInsets.only(right: 20))));
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
