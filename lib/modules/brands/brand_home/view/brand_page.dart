import 'package:turtlz/modules/brands/brand_home/components/brand_list_tile.dart';
import 'package:turtlz/modules/brands/brand_home/cubit/brand_cubit.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class BrandPage extends StatefulWidget {
  @override
  _BrandPageState createState() => _BrandPageState();
}

class _BrandPageState extends State<BrandPage> {
  late BrandCubit _brandCubit;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _brandCubit = BlocProvider.of<BrandCubit>(context);
    _brandCubit.getBrands();
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
    if (maxScroll - currentScroll == 0 && _brandCubit.state.next != null) {
      _brandCubit.getBrands();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      BlocBuilder<BrandCubit, BrandListState>(builder: (context, state) {
        if (state.isLoaded == true) {
          return Column(children: [
            for (var brand in state.brands!)
              BrandListTile(
                  Id: brand.Id,
                  name: brand.name,
                  description: brand.description,
                  logo: brand.logo)
          ]);
        }
        return Padding(
            padding: EdgeInsets.only(top: Adaptive.h(20)),
            child: Center(
                child: Image.asset('assets/images/indicator.gif',
                    width: 100, height: 100)));
      }),
      SizedBox(height: Adaptive.h(5))
    ]));
  }
}
