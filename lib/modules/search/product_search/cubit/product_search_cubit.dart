import 'package:turtlz/repositories/search_repository/src/search_repository.dart';
import 'package:turtlz/support/networks/network_exceptions.dart';
import 'package:turtlz/support/networks/page_response.dart';
import 'package:turtlz/support/networks/api_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'product_search_state.dart';

class ProductSearchCubit extends Cubit<ProductSearchState> {
  ProductSearchCubit(this._searchRepository)
      : super(const ProductSearchState(
          isLoading: true,
          isLoaded: false,
          maxIndex: false,
          page: 1,
        ));

  final SearchRepository _searchRepository;

  Future<void> productSearch(String keyword, int page) async {
    emit(state.copyWith(
      products: [],
      maxIndex: false,
    ));

    ApiResult<PageResponse> apiResult =
        await _searchRepository.productSearch(keyword, state.page);

    apiResult.when(success: (PageResponse? pageResponse) {
      List<dynamic>? newProductList = pageResponse!.results;

      emit(state.copyWith(
          products: state.products != null
              ? state.products! + newProductList!
              : newProductList!,
          count: pageResponse.count,
          page: state.page + 1,
          next: pageResponse.next,
          previous: pageResponse.previous,
          maxIndex: pageResponse.next == null ? true : false,
          isLoading: false,
          isLoaded: true));
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(
        error: error,
        errorMessage: NetworkExceptions.getErrorMessage(error!),
      ));
    });
  }
}
