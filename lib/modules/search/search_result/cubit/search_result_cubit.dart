import 'package:turtlz/repositories/search_repository/src/search_repository.dart';
import 'package:turtlz/support/networks/network_exceptions.dart';
import 'package:turtlz/support/networks/page_response.dart';
import 'package:turtlz/support/networks/api_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'search_result_state.dart';

class SearchResultCubit extends Cubit<SearchResultState> {
  SearchResultCubit(this._searchRepository)
      : super(
            const SearchResultState(isLoading: true, isLoaded: false, page: 1));

  final SearchRepository _searchRepository;

  Future<void> search(String keyword, int page) async {
    ApiResult<Map> apiResult = await _searchRepository.search(keyword, page);
    apiResult.when(success: (Map? mapResponse) {
      emit(state.copyWith(
        isLoaded: true,
        isLoading: false,
        products: mapResponse!['results']['products'],
        brands: mapResponse['results']['brands'],
      ));
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(error: error));
    });
  }
}
