import 'package:turtlz/repositories/search_repository/src/search_repository.dart';
import 'package:turtlz/repositories/brand_repository/models/brand_list.dart';
import 'package:turtlz/support/networks/network_exceptions.dart';
import 'package:turtlz/support/networks/page_response.dart';
import 'package:turtlz/support/networks/api_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'brand_search_state.dart';

class BrandSearchCubit extends Cubit<BrandSearchState> {
  BrandSearchCubit(this._searchRepository)
      : super(const BrandSearchState(
          isLoading: true,
          isLoaded: false,
          maxIndex: false,
          page: 1,
        ));

  final SearchRepository _searchRepository;

  Future<void> brandSearch(String keyword, int page) async {
    ApiResult<Map> apiResult =
        await _searchRepository.brandSearch(keyword, state.page);

    apiResult.when(success: (Map? mapResponse) {
      List<dynamic>? newBrandList = mapResponse!['results'];

      emit(state.copyWith(
          brands: state.brands != null
              ? state.brands! + newBrandList!
              : newBrandList!,
          count: mapResponse['count'],
          page: state.page + 1,
          next: mapResponse['next'].toString(),
          previous: mapResponse['previous'].toString(),
          maxIndex: mapResponse['next'] == null ? true : false,
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
