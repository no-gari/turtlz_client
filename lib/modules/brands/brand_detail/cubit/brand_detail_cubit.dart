import 'package:turtlz/repositories/brand_repository/src/brand_repository.dart';
import 'package:turtlz/support/networks/network_exceptions.dart';
import 'package:turtlz/support/networks/api_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'brand_detail_state.dart';

class BrandDetailCubit extends Cubit<BrandDetailState> {
  BrandDetailCubit(this._brandDetailRepository)
      : super(const BrandDetailState(isLoading: true, isLoaded: false));

  final BrandRepository _brandDetailRepository;

  Future<void> getBrandDetail(String id) async {
    emit(state.copyWith(isLoading: true, isLoaded: false));

    ApiResult<Map> mapResponse = await _brandDetailRepository.getBrand(id);

    mapResponse.when(success: (Map? mapResponse) {
      emit(state.copyWith(
          Id: mapResponse!['Id'],
          name: mapResponse['name'],
          description: mapResponse['description'],
          logo: mapResponse['logo'],
          magazines: mapResponse['magazines'],
          products: mapResponse['products'],
          isLoading: false,
          isLoaded: true));
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(error: error));
    });
  }

  Future<void> getBrandMagazines(String id) async {
    ApiResult<Map> mapResponse =
        await _brandDetailRepository.getBrandMagazines(id);

    mapResponse.when(success: (Map? mapResponse) {
      emit(state.copyWith(
          Id: '',
          name: '',
          description: '',
          logo: '',
          magazines: mapResponse!['magazines'],
          products: [],
          isLoading: false,
          isLoaded: true));
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(error: error));
    });
  }
}
