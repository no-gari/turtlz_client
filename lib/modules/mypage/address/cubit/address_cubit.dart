import 'package:turtlz/repositories/address_repository/src/address_repository.dart';
import 'package:turtlz/repositories/address_repository/models/address.dart';
import 'package:turtlz/support/networks/network_exceptions.dart';
import 'package:turtlz/support/networks/api_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit(this._addressRepository) : super(const AddressState());

  final AddressRepository _addressRepository;

  Future<void> getAddressList() async {
    ApiResult<List> apiResult = await _addressRepository.getAddressList();

    apiResult.when(success: (List? listResponse) {
      emit(state.copyWith(
        addresses:
            listResponse!.map((address) => Address.fromJson(address)).toList(),
        isLoading: false,
        isLoaded: true,
      ));
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(error: error));
    });
  }

  Future<void> createAddress(Address address) async {
    Address newAddress = Address(
      name: address.name,
      bigAddress: address.bigAddress,
      smallAddress: address.smallAddress,
      postalCode: address.postalCode,
      phoneNumber: address.phoneNumber,
      isDefault: address.isDefault,
    );
    ApiResult<Address> apiResult =
        await _addressRepository.createAddress(newAddress);

    apiResult.when(success: (Address? response) {
      if (response!.isDefault!) {
        emit(state.copyWith(
            addresses: state.addresses!
                    .map((adr) => adr.copyWith(isDefault: false))
                    .toList() +
                [response]));
      } else {
        emit(state.copyWith(
          addresses: state.addresses! + [response],
        ));
      }
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(error: error));
    });
  }

  Future<void> deleteAddress(int addressId) async {
    ApiResult<dynamic> apiResult =
        await _addressRepository.deleteAddress(addressId);

    List<Address> addresses = [];

    state.addresses!.forEach((address) {
      if (address.id != addressId) {
        addresses.add(address);
      }
    });
    apiResult.when(success: (dynamic response) {
      emit(state.copyWith(
        addresses: addresses,
        isLoading: false,
        isLoaded: true,
      ));
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(error: error));
    });
  }

  Future<void> updateDefaultAddress(int addressId) async {
    ApiResult<dynamic> apiResult =
        await _addressRepository.updateDefaultAddress(addressId);

    List<Address> addresses = [];

    state.addresses!.forEach((address) {
      if (address.id != addressId) {
        addresses.add(address.copyWith(isDefault: false));
      } else {
        addresses.add(address.copyWith(isDefault: true));
      }
    });
    apiResult.when(success: (dynamic response) {
      emit(state.copyWith(
        addresses: addresses,
        isLoading: false,
        isLoaded: true,
      ));
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(error: error));
    });
  }
}
