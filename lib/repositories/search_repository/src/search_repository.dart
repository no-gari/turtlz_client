import 'package:turtlz/support/networks/network_exceptions.dart';
import 'package:turtlz/support/networks/page_response.dart';
import 'package:turtlz/support/networks/api_result.dart';
import 'package:turtlz/support/networks/dio_client.dart';

class SearchRepository {
  SearchRepository(this._dioClient);

  final DioClient _dioClient;

  Future<ApiResult<PageResponse>> getKeywordList(int page) async {
    try {
      var response =
          await _dioClient.get('/api/v1/commerce/search/?page=${page}');
      return ApiResult.success(data: PageResponse.fromJson(response));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<PageResponse>> productSearch(
      String keyword, int page) async {
    try {
      var response = await _dioClient
          .get('/api/v1/commerce/search/product/${keyword}/?page=${page}');
      return ApiResult.success(data: PageResponse.fromJson(response));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<Map>> brandSearch(String keyword, int page) async {
    try {
      var response = await _dioClient
          .get('/api/v1/commerce/search/brand/${keyword}/?page=${page}');
      print('======================');
      print(response);
      print('======================');
      return ApiResult.success(data: response);
    } catch (e) {
      print('======================');
      print('fail');
      print('======================');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<Map>> search(String keyword, int page) async {
    try {
      var response = await _dioClient
          .get('/api/v1/commerce/search/${keyword}/?page=${page}');
      return ApiResult.success(data: response);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
