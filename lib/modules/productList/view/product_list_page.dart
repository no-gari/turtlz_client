import 'package:turtlz/repositories/store_repository/models/collection.dart';
import 'package:turtlz/modules/store/components/store_product_widget.dart';
import 'package:turtlz/modules/store/cubit/store_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  int page = 1;
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
      print(_selectedCollection.Id);
    }
    _storeCubit.getSubCollection();
    _scrollController.addListener(_onScroll);
    _storeCubit.getProductsByCollection(_selectedCollection.Id, sort, page);
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll == 0 && _storeCubit.state.maxIndex == false) {
      page += 1;
      _storeCubit.getProductsByCollection(_selectedCollection.Id, sort, page);
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
                          onTap: () => showFilterSheet(context),
                          child: const Padding(
                              padding: EdgeInsets.only(right: 20),
                              child: Icon(Icons.filter_list_sharp)))
                    ],
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
        padding: EdgeInsets.only(left: 10),
        height: 50,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () => setState(() {
                        _selectedCollection = state.subCollections![index];
                        page = 1;
                        _storeCubit.getProductsByCollection(
                            _selectedCollection.Id, sort, page);
                      }),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
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

void showFilterSheet(BuildContext context) {
  showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      builder: (context) => Container(height: 250, padding: EdgeInsets.all(5)),
      isScrollControlled: false);
}
