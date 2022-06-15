import 'package:turtlz/modules/notification/view/notification_screen.dart';
import 'package:turtlz/modules/home/view/category_page.dart';
import 'package:extended_tabs/extended_tabs.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';
import 'dart:math' as math;

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(alignment: Alignment.topCenter, children: <Widget>[
      Expanded(
          child: ExtendedTabBarView(
              children: <Widget>[CategoryPage(), CategoryPage()],
              scrollDirection: Axis.vertical,
              controller: _tabController)),
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ExtendedTabBar(
            mainAxisAlignment: MainAxisAlignment.start,
            isScrollable: true,
            labelColor: Colors.black,
            controller: _tabController,
            scrollDirection: Axis.vertical,
            tabs: [Tab(child: Text('hihi')), Tab(child: Text('Dart'))])
      ]),
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Row(children: [
            Text('DISCOVER', style: TextStyle(color: Colors.black)),
            IconButton(onPressed: () {}, icon: Icon(Icons.search)),
            IconButton(
                onPressed: () =>
                    context.vRouter.to(NotificationScreen.routeName),
                icon: Icon(Icons.notifications_outlined))
          ]))
    ]));

    // DefaultTabController(
    //   length: _tabs.length, // This is the number of tabs.
    //   child: NestedScrollView(
    //       headerSliverBuilder:
    //           (BuildContext context, bool innerBoxIsScrolled) {
    //         return <Widget>[
    //           SliverOverlapAbsorber(
    //               handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
    //                   context),
    //               sliver: SliverSafeArea(
    //                   top: false,
    //                   sliver: SliverAppBar(
    //                       toolbarHeight: 400,
    //                       expandedHeight: 400,
    //                       automaticallyImplyLeading: false,
    //                       pinned: true,
    //                       floating: true,
    //                       snap: true,
    //                       flexibleSpace: FlexibleSpaceBar(
    //                           background: Stack(children: [
    //                         CarouselPage(),
    //                         Positioned(
    //                             right: 0,
    //                             child: Container(
    //                                 padding: EdgeInsets.symmetric(
    //                                     vertical:
    //                                         AppBar().preferredSize.height,
    //                                     horizontal: 18),
    //                                 child: IconButton(
    //                                     icon: Icon(
    //                                         Icons.notifications_outlined),
    //                                     onPressed: () => context.vRouter.to(
    //                                         NotificationScreen.routeName))))
    //                       ])),
    //                       bottom: TabBar(
    //                           labelColor: Colors.black,
    //                           unselectedLabelColor: Colors.grey,
    //                           isScrollable: true,
    //                           labelStyle:
    //                               Theme.of(context).textTheme.headline4!,
    //                           tabs: _tabs
    //                               .map((String name) => Tab(text: name))
    //                               .toList()))))
    //         ];
    //       },
    //       body: TabBarView(
    //           children: _tabs.map((String name) {
    //         return SafeArea(
    //             top: false,
    //             bottom: false,
    //             child: Builder(builder: (BuildContext context) {
    //               return CustomScrollView(
    //                   key: PageStorageKey<String>(name),
    //                   slivers: <Widget>[
    //                     SliverOverlapInjector(
    //                         handle: NestedScrollView
    //                             .sliverOverlapAbsorberHandleFor(context)),
    //                     SliverToBoxAdapter(
    //                         child: Container(
    //                             height:
    //                                 MediaQuery.of(context).size.height * 0.8 -
    //                                     TabBar(tabs: []).preferredSize.height,
    //                             child: CategoryPage()))
    //                   ]);
    //             }));
    //       }).toList())));
  }
}
