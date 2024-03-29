import 'package:turtlz/modules/brands/brand_home/components/brand_list_tile.dart';
import 'package:turtlz/modules/search/brand_search/cubit/brand_search_cubit.dart';
import 'package:turtlz/repositories/brand_repository/models/brand_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class BrandSearchPage extends StatefulWidget {
  BrandSearchPage({this.keyword});

  final String? keyword;

  @override
  _BrandSearchPageState createState() => _BrandSearchPageState();
}

class _BrandSearchPageState extends State<BrandSearchPage> {
  late BrandSearchCubit _brandSearchCubit;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _brandSearchCubit = BlocProvider.of<BrandSearchCubit>(context);
    _brandSearchCubit.brandSearch(widget.keyword!);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (currentScroll == maxScroll) {
      _brandSearchCubit.brandSearch(widget.keyword!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: true,
            title: Text('브랜드 / ${widget.keyword.toString()}',
                style: Theme.of(context).textTheme.headline5)),
        body: SafeArea(
            child: SingleChildScrollView(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: BlocBuilder<BrandSearchCubit, BrandSearchState>(
                    builder: (context, state) {
                  if (state.isLoaded) {
                    List<BrandList> brandList = List<BrandList>.from(state
                        .brands!
                        .map((model) => BrandList(model['Id'], model['name'])));

                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (state.brands!.isNotEmpty) Container(height: 20),
                          if (state.brands!.isNotEmpty)
                            for (var brand in brandList)
                              BrandListTile(Id: brand.Id, name: brand.name)
                        ]);
                  }
                  return Center(
                      child: Image.asset('assets/images/indicator.gif',
                          width: 100, height: 100));
                }))));
  }
}
