import 'package:turtlz/repositories/store_repository/models/collection.dart';
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
      Collection collection, String sort, int page) async {
    try {
      String collectionName = collection.Id == null ? "" : collection.Id + "/";

      var response = await _dioClient.get(
          '/api/v1/commerce/product/${collectionName}list?page=$page&sort=$sort');

      return ApiResult.success(data: PageResponse.fromJson(response));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<List>> getSubCollection(Collection collection) async {
    try {
      var response =
          await _dioClient.get('/api/v1/commerce/collection/${collection.Id}/');

      return ApiResult.success(data: response);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
