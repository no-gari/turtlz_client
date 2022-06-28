import 'package:turtlz/repositories/store_repository/models/banner_collection.dart';
import 'package:turtlz/repositories/store_repository/models/main_collection.dart';
import 'package:turtlz/repositories/store_repository/src/store_repository.dart';
import 'package:turtlz/repositories/store_repository/models/collection.dart';
import 'package:turtlz/repositories/product_repository/models/product.dart';
import 'package:turtlz/repositories/product_repository/models/brand.dart';
import 'package:turtlz/repositories/store_repository/models/menu.dart';
import 'package:turtlz/support/networks/network_exceptions.dart';
import 'package:turtlz/support/networks/page_response.dart';
import 'package:turtlz/support/networks/api_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'store_state.dart';

class StoreCubit extends Cubit<StoreState> {
  StoreCubit(this._storeRepository) : super(StoreState(isLoaded: false));

  final StoreRepository _storeRepository;

  Future<void> initMenu(Collection collection) async {
    emit(state.copyWith(selectedMenu: collection));
  }

  Future<void> selectedCollection(Collection selected) async {
    emit(state.copyWith(selectedMenu: selected));
  }

  Future<void> getCollections() async {
    ApiResult<List> apiResult = await _storeRepository.getCollection();

    apiResult.when(success: (List? listResponse) {
      emit(state.copyWith(
          isLoaded: true,
          collections: listResponse!.map((e) => Menu.fromJson(e)).toList()));
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(error: error));
    });
  }

  Future<void> getPopupCollection() async {
    ApiResult<List> apiResult = await _storeRepository.getPopupCollection();

    apiResult.when(success: (List? listResponse) {
      emit(state.copyWith(
          isLoaded: true,
          popupCollections:
              listResponse!.map((e) => Menu.fromJson(e)).toList()));
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(error: error));
    });
  }

  Future<void> getSubCollection() async {
    ApiResult<List> apiResult = await _storeRepository.getSubCollection();

    apiResult.when(success: (List? listResponse) {
      emit(state.copyWith(
          isLoaded: true,
          subCollections: [Collection('', "전체보기", '')] +
              listResponse!.map((e) => Collection.fromJson(e)).toList()));
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(error: error));
    });
  }

  Future<void> getProductsByCollection(
      bool isNew, String collection, String sort) async {
    if (isNew == true) {
      emit(state.copyWith(page: 1));
    }

    ApiResult<PageResponse> apiResult = await _storeRepository
        .getProductsByCollection(collection, sort, state.page!);

    apiResult.when(success: (PageResponse? pageResponse) {
      List<Product> newProducts = [];

      if (pageResponse!.count != null) {
        newProducts = pageResponse.results!.map((e) {
          return Product(
            Id: e["Id"],
            name: e["name"],
            rating: e["rating"],
            originalPrice: e["originalPrice"],
            discountPrice: e["discountPrice"],
            discountRate: e["discountRate"],
            brand: Brand(name: e["brand"]),
            thumbnail: e["thumbnail"],
          );
        }).toList();
      }

      emit(
        state.copyWith(
          isLoaded: true,
          products:
              state.page == 1 ? newProducts : state.products! + newProducts,
          next: pageResponse.next,
          previous: pageResponse.previous,
          count: pageResponse.count,
          page: state.page! + 1,
          maxIndex: pageResponse.next == null ? true : false,
        ),
      );
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(error: error));
    });
  }

  Future<void> getMainCollection() async {
    ApiResult<List<dynamic>> apiResult =
        await _storeRepository.getMainCollection();

    apiResult.when(success: (List<dynamic>? listResponse) {
      emit(
        state.copyWith(isLoaded: true, mainCollections: listResponse!),
      );
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(error: error));
    });
  }

  // Future<void> getMainCollection() async {
  //   emit(state.copyWith(isLoaded: false));

  //
  // apiResult.when(success: (List<MainCollection>? listResponse) {
  //   List<MainCollection> mainCollections = [];
  //
  //   if (apiResult != null) {
  //     mainCollections = apiResult.map((e) {
  //       return MainCollection(
  //
  //       );
  //     }).toList();

  // List<Product> productList = List<Product>.from(state
  //     .mainCollections![i]['products']
  //     .map((model) => Product(
  //     Id: model['Id'],
  //     name: model['name'],
  //     rating: model['rating'],
  //     originalPrice: model['originalPrice'],
  //     discountPrice: model['discountPrice'],
  //     discountRate: model['discountRate'],
  //     thumbnail: model['thumbnail'],
  //     brand: Brand(name: model['brand']))));
  //
  // productChildren.add(productList);
  // return Text(
  //     state.mainCollections![i]['collection']['name']);

  // emit(state.copyWith(isLoaded: true, mainCollections: listResponse));
  //   }, failure: (NetworkExceptions? error) {
  //     emit(state.copyWith(error: error));
  //   });
  // }
}
