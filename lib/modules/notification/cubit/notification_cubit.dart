import 'package:turtlz/repositories/notification_repository/src/notification_repository.dart';
import 'package:turtlz/repositories/notification_repository/models/notification.dart';
import 'package:turtlz/support/networks/api_result.dart';
import 'package:turtlz/support/networks/network_exceptions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:turtlz/support/networks/page_response.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(this._notificationRepository)
      : super(const NotificationState(
          isLoading: true,
          isLoaded: false,
          maxIndex: false,
          page: 1,
        ));

  final NotificationRepository _notificationRepository;

  Future<void> getNotification() async {
    emit(state.copyWith(
      notification: [],
      maxIndex: false,
    ));

    ApiResult<PageResponse> apiResult =
        await _notificationRepository.getNotification(state.page);

    apiResult.when(success: (PageResponse? pageResponse) {
      emit(state.copyWith(
        notification: pageResponse!.results!
            .map((e) => Notification.fromJson(e))
            .toList(),
        count: pageResponse.count,
        page: state.page + 1,
        next: pageResponse.next,
        previous: pageResponse.previous,
        maxIndex: pageResponse.next == null ? true : false,
        isLoading: false,
        isLoaded: true,
      ));
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(
        error: error,
        errorMessage: NetworkExceptions.getErrorMessage(error!),
      ));
    });
  }
}
