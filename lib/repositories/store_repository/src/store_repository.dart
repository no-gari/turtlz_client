import 'package:turtlz/support/networks/network_exceptions.dart';
import 'package:turtlz/support/networks/page_response.dart';
import 'package:turtlz/support/networks/api_result.dart';
import 'package:turtlz/support/networks/dio_client.dart';

class CollectionGetFailure implements Exception {}

class StoreRepository {
  StoreRepository(this._dioClient);

  final DioClient _dioClient;

  Future<ApiResult<List>> getCollection() async {
    try {
      var response = await _dioClient.get('/api/v1/commerce/collection/');
      return ApiResult.success(data: response);
    } on Exception {
      throw CollectionGetFailure();
    }
  }

  Future<ApiResult<PageResponse>> getProductsByCollection(
      String collection, String sort, int page) async {
    try {
      var response = await _dioClient.get(
          '/api/v1/commerce/product/${collection}/list?page=$page&sort=$sort');
      return ApiResult.success(data: PageResponse.fromJson(response));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<List>> getMainCollection() async {
    try {
      var response = await _dioClient.get('/api/v1/commerce/collection/main/');
      return ApiResult.success(data: response);
    } catch (e) {
      throw ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  // Future<ApiResult<List>> getSubCollection() async {
  //   try {
  //     var response = await _dioClient.get('/api/v1/commerce/collection/');
  //     return ApiResult.success(data: response);
  //   } catch (e) {
  //     throw ApiResult.failure(error: NetworkExceptions.getDioException(e));
  //   }
  // }
}
