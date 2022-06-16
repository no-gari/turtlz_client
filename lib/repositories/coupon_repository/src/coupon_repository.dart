import 'package:turtlz/support/networks/network_exceptions.dart';
import 'package:turtlz/support/networks/api_result.dart';
import 'package:turtlz/support/networks/dio_client.dart';

class CouponRepository {
  CouponRepository(this._dioClient);

  final DioClient _dioClient;

  Future<ApiResult<List>> getCouponList() async {
    try {
      var response =
          await _dioClient.getWithAuth('/api/v1/commerce/coupon/list/');

      return ApiResult.success(data: response);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
