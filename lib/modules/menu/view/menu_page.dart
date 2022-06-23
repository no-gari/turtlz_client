import 'package:turtlz/repositories/authentication_repository/authentication_repository.dart';
import 'package:turtlz/modules/brands/brand_detail/view/brand_detail_screen.dart';
import 'package:turtlz/modules/authentication/bloc/authentication_bloc.dart';
import 'package:turtlz/modules/productList/view/product_list_screen.dart';
import 'package:turtlz/modules/brands/brand_home/cubit/brand_cubit.dart';
import 'package:turtlz/support/base_component/login_needed.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:turtlz/modules/store/cubit/store_cubit.dart';
import 'package:turtlz/support/style/format_unit.dart';
import 'package:turtlz/support/style/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';
import 'dart:math' as math;

class MenuPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<MenuPage> {
  final PageController _pageController = PageController(initialPage: 0);

  late StoreCubit _storeCubit;
  late BrandCubit _brandCubit;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _storeCubit = BlocProvider.of<StoreCubit>(context);
    _brandCubit = BlocProvider.of<BrandCubit>(context);
    _storeCubit.getCollections();
    _brandCubit.getBrands();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      return Material(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: SafeArea(
              child: DefaultTabController(
                  length: 2,
                  child: NestedScrollView(
                      headerSliverBuilder: (context, innerBoxIsScrolled) {
                        return [
                          storeAppBarWidget(state: state),
                          SliverOverlapAbsorber(
                              handle: NestedScrollView
                                  .sliverOverlapAbsorberHandleFor(context),
                              sliver: SliverPersistentHeader(
                                  pinned: true, delegate: TabBarDelegate()))
                        ];
                      },
                      body: Column(children: [
                        const SizedBox(height: 48),
                        Expanded(
                            child: TabBarView(children: [
                          buildFirstPage(),
                          buildSecondPage()
                        ]))
                      ])))));
    });
  }

  SingleChildScrollView buildFirstPage() {
    return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          BlocBuilder<StoreCubit, StoreState>(builder: (context, state) {
            if (state.isLoaded) {
              return Column(children: [
                const SizedBox(height: 10),
                GridMenu(state: state)
                // 이벤트 들어갈 자리.
              ]);
            } else {
              return Padding(
                  padding: EdgeInsets.only(top: maxHeight(context) * 0.25),
                  child: Center(
                      child: Image.asset('assets/images/indicator.gif',
                          width: 100, height: 100)));
            }
          })
        ]));
  }

  SingleChildScrollView buildSecondPage() {
    return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child:
            BlocBuilder<BrandCubit, BrandListState>(builder: (context, state) {
          if (state.isLoaded && state.brands!.isNotEmpty) {
            return Column(children: [
              for (var brand in state.brands!)
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    onTap: () {
                      context.vRouter.toNamed(BrandDetailScreen.routeName,
                          pathParameters: {'brandId': brand.Id!});
                    },
                    leading: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(brand.logo!),
                        radius: 20),
                    title: Text(brand.name!,
                        style: Theme.of(context).textTheme.headline5))
            ]);
          }
          return Padding(
            padding: EdgeInsets.only(top: maxHeight(context) * 0.25),
            child: Center(
                child: Image.asset('assets/images/indicator.gif',
                    width: 100, height: 100)),
          );
        }));
  }
}

class GridMenu extends StatelessWidget {
  const GridMenu({this.state});

  final StoreState? state;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.2,
        children: [
          for (var collection in state!.collections!)
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductListScreen(
                              collectionId: collection.Id,
                              collectionName: collection.name)));
                },
                child: Column(children: [
                  const CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(
                          'https://turtlz.co/wp-content/uploads/2022/05/164914909505337189-860x860.jpg')),
                  const SizedBox(height: 5),
                  Text(collection.name,
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: Colors.black))
                ]))
        ]);
  }
}

// 스토어 최상단 부분 (store, 검색)
class storeAppBarWidget extends StatelessWidget {
  final AuthenticationState? state;

  storeAppBarWidget({@required this.state});

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
                    padding: const EdgeInsets.symmetric(horizontal: 20),
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
                                onPressed: () => state!.status ==
                                        AuthenticationStatus.authenticated
                                    ? context.vRouter.toNamed('/notification')
                                    : showSocialLoginNeededDialog(context),
                                icon: ImageIcon(
                                    const Svg("assets/icons/noti.svg"),
                                    color: theme.primaryColor))
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
