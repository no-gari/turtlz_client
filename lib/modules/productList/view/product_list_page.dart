import 'package:turtlz/repositories/store_repository/models/collection.dart';
import 'package:turtlz/modules/store/components/store_product_widget.dart';
import 'package:turtlz/modules/store/cubit/store_cubit.dart';
import 'package:turtlz/support/style/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class ProductListPage extends StatefulWidget {
  ProductListPage({this.collectionId, this.collectionName, this.thumbnail});

  final String? collectionId;
  final String? collectionName;
  final String? thumbnail;

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  late StoreCubit _storeCubit;
  late Collection _selectedCollection;
  String sort = 'price.sale';

  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _storeCubit = BlocProvider.of<StoreCubit>(context);
    if (widget.collectionId == null) {
      _selectedCollection = Collection('', '전체보기', '');
    } else {
      _selectedCollection = Collection(
          widget.collectionId!, widget.collectionName!, widget.thumbnail!);
    }
    _storeCubit.getSubCollection();
    _scrollController.addListener(_onScroll);
    _storeCubit.getProductsByCollection(true, _selectedCollection.Id, sort);
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll == 0 && _storeCubit.state.maxIndex == false) {
      _storeCubit.getProductsByCollection(false, _selectedCollection.Id, sort);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreCubit, StoreState>(builder: (context, state) {
      return BlocBuilder<StoreCubit, StoreState>(builder: (context, state) {
        return state.isLoaded == true
            ? Scaffold(
                appBar: AppBar(
                    actions: [
                      GestureDetector(
                          onTap: () => showModalBottomSheet(
                              context: context,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(25),
                                      topRight: Radius.circular(25))),
                              builder: (BuildContext context) {
                                String bottomSort = 'price.sale';

                                return StatefulBuilder(builder: (BuildContext context, StateSetter mystate) {
                                  return Container(
                                      height: 150,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 20),
                                            Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text('filter.',
                                                      style: theme
                                                          .textTheme.headline5),
                                                  GestureDetector(
                                                      onTap: () {
                                                        _storeCubit
                                                            .getProductsByCollection(
                                                            true,
                                                            _selectedCollection
                                                                .Id,
                                                            sort);
                                                        Navigator.of(context).pop();
                                                      },
                                                      child: Container(
                                                        child: Text('적용하기',
                                                            style: theme.textTheme
                                                                .headline5!
                                                                .copyWith(
                                                                color: theme
                                                                    .primaryColor)),
                                                      ))
                                                ]),
                                            SizedBox(height: 20),
                                            Row(children: [
                                              Expanded(
                                                  child: GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          sort = 'price.sale';
                                                        });
                                                        mystate(() {
                                                          bottomSort = 'price.sale';
                                                        });
                                                      },
                                                      child: Container(
                                                          padding: EdgeInsets.all(10),
                                                          decoration: BoxDecoration(
                                                              color: bottomSort !=
                                                                  'price.sale'
                                                                  ? Colors.white
                                                                  : theme.primaryColor,
                                                              border: Border.all(
                                                                  color: theme
                                                                      .primaryColor),
                                                              borderRadius:
                                                              BorderRadius.circular(
                                                                  25)),
                                                          alignment: Alignment.center,
                                                          child: Text('가격 낮은 순',
                                                              style: theme
                                                                  .textTheme.headline5!
                                                                  .copyWith(
                                                                  color: bottomSort !=
                                                                      'price.sale'
                                                                      ? theme
                                                                      .primaryColor
                                                                      : Colors
                                                                      .white))
                                                      ))
                                              ),
                                              const SizedBox(width: 5),
                                              Expanded(
                                                child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        sort = '-price.sale';
                                                      });
                                                      mystate(() {
                                                        bottomSort = '-price.sale';
                                                      });
                                                    },
                                                    child: Container(
                                                      padding: EdgeInsets.all(10),
                                                      decoration: BoxDecoration(
                                                          color: bottomSort !=
                                                              '-price.sale'
                                                              ? Colors.white
                                                              : theme.primaryColor,
                                                          border: Border.all(
                                                              color: theme
                                                                  .primaryColor),
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              25)),
                                                      alignment: Alignment.center,
                                                      child: Text('가격 높은 순',
                                                          style: theme
                                                              .textTheme.headline5!
                                                              .copyWith(
                                                              color: bottomSort !=
                                                                  '-price.sale'
                                                                  ? theme
                                                                  .primaryColor
                                                                  : Colors
                                                                  .white)),
                                                    )),
                                              ),
                                              const SizedBox(width: 5),
                                              Expanded(
                                                  child: GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          sort = '-createdAt';
                                                        });
                                                        mystate(() {
                                                          bottomSort = '-createdAt';
                                                        });
                                                      },
                                                      child: Container(
                                                          padding:
                                                          const EdgeInsets.all(10),
                                                          decoration: BoxDecoration(
                                                              color: bottomSort != '-createdAt'
                                                                  ? Colors.white
                                                                  : theme
                                                                  .primaryColor,
                                                              border: Border.all(
                                                                  color: theme
                                                                      .primaryColor),
                                                              borderRadius:
                                                              BorderRadius.circular(
                                                                  25)),
                                                          alignment:
                                                          Alignment.center,
                                                          child: Text('최신 순',
                                                              style: theme.textTheme
                                                                  .headline5!
                                                                  .copyWith(
                                                                  color: bottomSort != '-createdAt'
                                                                      ? theme.primaryColor
                                                                      : Colors.white)))))
                                            ]),
                                            const SizedBox(height: 10),
                                            // Text('color.',
                                            //     style: theme.textTheme.headline5),
                                            // const SizedBox(height: 5),
                                            // GridView.count(
                                            //     physics:
                                            //     const NeverScrollableScrollPhysics(),
                                            //     shrinkWrap: true,
                                            //     crossAxisCount: 5,
                                            //     crossAxisSpacing: 5,
                                            //     mainAxisSpacing: 5,
                                            //     childAspectRatio: 1.7,
                                            //     children: List.generate(
                                            //         colorList.length,
                                            //             (index) => Container(
                                            //               alignment: Alignment.center,
                                            //               decoration: BoxDecoration(
                                            //                   borderRadius:
                                            //                   BorderRadius.circular(
                                            //                       25),
                                            //                   border: Border.all(
                                            //                       color: theme
                                            //                           .primaryColor)),
                                            //               child: Text(
                                            //                   colorList[index]['name']
                                            //                       .toString(),
                                            //                   style: theme.textTheme
                                            //                       .headline6!
                                            //                       .copyWith(
                                            //                       color: theme.primaryColor))),
                                            //             )
                                            //     )
                                          ]));
                                });
                              } ,
                              isScrollControlled: false),
                          child: const Padding(
                              padding: EdgeInsets.only(right: 20),
                              child: Icon(Icons.filter_list_sharp)))
                    ],
                    title:
                        SvgPicture.asset("assets/images/turtlz.svg", width: 80),
                    automaticallyImplyLeading: true,
                    bottom: PreferredSize(
                        preferredSize: const Size.fromHeight(50),
                        child: state.isLoaded == true &&
                                state.subCollections != null
                            ? subCategoryWidget(state)
                            : Container())),
                body: BlocBuilder<StoreCubit, StoreState>(
                    builder: (context, state) {
                  if (state.subCollections != null &&
                      state.subCollections!.isNotEmpty) {
                    return SingleChildScrollView(
                        controller: _scrollController,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 서브 카테고리
                              if (state.products != null &&
                                  state.products!.isNotEmpty)
                                const SizedBox(height: 20),
                              state.products != null &&
                                      state.products!.isNotEmpty
                                  ? GridView.count(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 5,
                                      mainAxisSpacing: 15,
                                      childAspectRatio: (4 / 7.5),
                                      children: List.generate(
                                          state.products!.length,
                                          (index) => storeProduct(
                                              context, state.products![index])))
                                  : Container(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.35),
                                      child: Center(
                                          child: Column(children: [
                                        Text("no products :(",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline3),
                                        const SizedBox(height: 20),
                                        const Text('찾으시는 상품이 없습니다.')
                                      ])))
                            ]));
                  } else {
                    return Center(
                        child: Image.asset('assets/images/indicator.gif',
                            width: 100, height: 100));
                  }
                }))
            : Scaffold(
                appBar: AppBar(automaticallyImplyLeading: true),
                body: Center(
                    child: Image.asset('assets/images/indicator.gif',
                        width: 100, height: 100)));
      });
    });
  }

  Container subCategoryWidget(StoreState state) {
    return Container(
        padding: const EdgeInsets.only(left: 10),
        height: 50,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCollection = state.subCollections![index];
                      sort = 'price.sale';
                    });
                    _storeCubit.getProductsByCollection(
                        true, _selectedCollection.Id, sort);
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          border: _selectedCollection ==
                                  state.subCollections![index]
                              ? Border(
                                  bottom: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                      width: 2))
                              : Border()),
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(
                          left: 10,
                          right: 10,
                          bottom: _selectedCollection ==
                                  state.subCollections![index]
                              ? 3
                              : 5),
                      child: Text("${state.subCollections![index].name}",
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(
                                  color: _selectedCollection ==
                                          state.subCollections![index]
                                      ? Theme.of(context).primaryColor
                                      : Colors.black))));
            },
            itemCount: state.subCollections!.length));
  }
}

var colorList = [
  {'name': '옐로우', 'id': 'PTJ3UAT5R5DV'},
  {'name': '네이비', 'id': 'KU8KB7MKTQJ7'},
  {'name': '핑크', 'id': '6FVMGUW6FHPD'},
  {'name': '레드', 'id': 'MPFPX5F7A4VW'},
  {'name': '멀티', 'id': 'NNJCKNJWT8TP'},
  {'name': '베이지', 'id': 'MFAFSJT5UWW9'},
  {'name': '브라운', 'id': 'VN56J2HK6H4R'},
  {'name': '블루', 'id': '7T3C5VWXS3CX'},
  {'name': '그린', 'id': 'LMAGF9PBE2F7'},
  {'name': '오렌지', 'id': '69GXG8WEWZE8'},
  {'name': '실버', 'id': 'Z6MH5V5GNJF8'},
  {'name': '바이올렛', 'id': 'HLFRR4JSQQCJ'},
  {'name': '블랙', 'id': 'XBX7QN64NRWT'},
  {'name': '골드', 'id': 'NWR42BW5L8HQ'},
  {'name': '화이트', 'id': '55KHHK4R9PBE'},
  {'name': '그레이', 'id': 'FN8YGZQW7F2R'},
  {'name': '투명', 'id': 'ZHHR375W92FU'},
];
