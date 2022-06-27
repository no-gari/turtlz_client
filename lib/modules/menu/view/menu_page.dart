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
  final ScrollController _brandScrollController = ScrollController();

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
    _brandCubit.getBrands(40);

    _brandScrollController.addListener(_brandOnScroll);
  }

  void _brandOnScroll() async {
    final maxScroll = _brandScrollController.position.maxScrollExtent;
    final currentScroll = _brandScrollController.position.pixels;
    if (currentScroll == maxScroll) {
      _brandCubit.getBrands(40);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _brandScrollController.dispose();
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
                GridMenu(state: state),
                // 배너 들어갈 곳
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductListScreen(
                              collectionId: '',
                              collectionName: '전체보기',
                              thumbnail: ''))),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset('assets/images/new_products_banner.png',
                            width: maxWidth(context)),
                        SizedBox(height: 5),
                        Text('터틀즈가 입수한 신상 캠핑용품!',
                            style: theme.textTheme.headline5)
                      ]),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductListScreen(
                              collectionId: 'CSQMZK7U8WGE',
                              collectionName: '화로/스토브',
                              thumbnail:
                                  'https://cdn.clayful.io/stores/ZCJ4P8CZH2UR.GZ5QLVHQY5XQ/images/2VAYYENZ27FT/v1/Ellipse_63.png'))),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset('assets/images/fire_banner.png',
                            width: maxWidth(context)),
                        SizedBox(height: 5),
                        Text('불멍하기 딱 좋은 요즘 날씨!',
                            style: theme.textTheme.headline5!)
                      ]),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductListScreen(
                              collectionId: 'VWLAH5XCDFSY',
                              collectionName: '캠핑소품',
                              thumbnail:
                                  'https://cdn.clayful.io/stores/ZCJ4P8CZH2UR.GZ5QLVHQY5XQ/images/G2DQQG53PD3G/v1/Ellipse_61.png'))),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset('assets/images/sensible_banner.png',
                            width: maxWidth(context)),
                        SizedBox(height: 5),
                        Text('감성캠핑에 빠질 수 없는 필수품 모음!',
                            style: theme.textTheme.headline5)
                      ]),
                ),
                SizedBox(height: 20),
                GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductListScreen(
                                collectionId: '',
                                collectionName: '전체보기',
                                thumbnail: ''))),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset('assets/images/shipping_banner.png',
                              width: maxWidth(context)),
                          const SizedBox(height: 5),
                          Text('터틀즈는 전 상품 무료배송 진행 중!',
                              style: theme.textTheme.headline5)
                        ])),
                const SizedBox(height: 30),
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
        controller: _brandScrollController,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child:
            BlocBuilder<BrandCubit, BrandListState>(builder: (context, state) {
          if (state.isLoaded && state.brands!.isNotEmpty) {
            return Column(children: [
              for (var brand in state.brands!)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              BrandDetailScreen(brandId: brand.Id))),
                  title: Text(brand.name!,
                      style: Theme.of(context).textTheme.headline5),
                  trailing: const Icon(Icons.arrow_forward_ios,
                      size: 15, color: Colors.black),
                ),
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
                              collectionName: collection.name,
                              thumbnail: collection.thumbnail)));
                },
                child: Column(children: [
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(collection.thumbnail),
                  ),
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
                labelColor: theme.primaryColor,
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
                indicator: UnderlineTabIndicator(
                    borderSide:
                        BorderSide(width: 2.0, color: theme.primaryColor),
                    insets: const EdgeInsets.only(bottom: -6)),
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
