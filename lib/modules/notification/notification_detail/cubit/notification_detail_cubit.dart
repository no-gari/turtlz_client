import 'package:sobe/repositories/notification_repository/src/notification_repository.dart';
import 'package:sobe/repositories/notification_repository/models/notification.dart';
import 'package:sobe/support/networks/network_exceptions.dart';
import 'package:sobe/support/networks/api_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'notification_detail_state.dart';

class NotificationDetailCubit extends Cubit<NotificationDetailState> {
  NotificationDetailCubit(this._notificationRepository)
      : super(const NotificationDetailState(
          isLoading: true,
          isLoaded: false,
        ));

  final NotificationRepository _notificationRepository;

  Future<void> getNotificationDetail(int id) async {
    emit(state.copyWith(isLoading: true, isLoaded: false));

    ApiResult<Notification> apiResult =
        await _notificationRepository.getNotificationDetail(id);

    apiResult.when(success: (Notification? notificationDetail) {
      emit(state.copyWith(
          notificationDetail: notificationDetail,
          isLoading: false,
          isLoaded: true));
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(error: error));
    });
  }
}
