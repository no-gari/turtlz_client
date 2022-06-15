part of 'notification_detail_cubit.dart';

class NotificationDetailState extends Equatable {
  const NotificationDetailState({
    this.notificationDetail,
    this.isLoaded = false,
    this.isLoading = true,
    this.error,
    this.errorMessage,
  });

  final Notification? notificationDetail;
  final bool isLoaded;
  final bool isLoading;
  final NetworkExceptions? error;
  final String? errorMessage;

  @override
  List<Object?> get props => [
        notificationDetail,
        isLoaded,
        isLoading,
        error,
        errorMessage,
      ];

  NotificationDetailState copyWith({
    Notification? notificationDetail,
    bool? isLoading,
    bool? isLoaded,
    NetworkExceptions? error,
    String? errorMessage,
  }) {
    return NotificationDetailState(
      notificationDetail: notificationDetail ?? this.notificationDetail,
      isLoading: isLoading ?? this.isLoading,
      isLoaded: isLoaded ?? this.isLoaded,
      error: error ?? this.error,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
