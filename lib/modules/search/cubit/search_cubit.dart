import 'package:turtlz/repositories/search_repository/models/recommended_keyword.dart';
import 'package:turtlz/repositories/search_repository/src/search_repository.dart';
import 'package:turtlz/support/networks/network_exceptions.dart';
import 'package:turtlz/support/networks/page_response.dart';
import 'package:turtlz/support/networks/api_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this._searchRepository)
      : super(const SearchState(
          isLoading: true,
          isLoaded: false,
          maxIndex: false,
          page: 1,
        ));

  final SearchRepository _searchRepository;

  Future<void> getKeywords() async {
    ApiResult<PageResponse> apiResult =
        await _searchRepository.getKeywordList(state.page);

    apiResult.when(success: (PageResponse? pageResponse) {
      List<RecommendedKeyword>? newKeywordList = pageResponse!.results
          ?.map((e) => RecommendedKeyword.fromJson(e))
          .toList();

      emit(state.copyWith(
          keywords: state.keywords != null
              ? state.keywords! + newKeywordList!
              : newKeywordList!,
          count: pageResponse.count,
          page: state.page + 1,
          next: pageResponse.next,
          previous: pageResponse.previous,
          maxIndex: pageResponse.next == null ? true : false,
          isLoaded: true,
          isLoading: false));
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(error: error));
    });
  }
}
