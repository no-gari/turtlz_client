part of 'notification_cubit.dart';

class NotificationState extends Equatable {
  const NotificationState({
    this.notification,
    this.isLoaded = false,
    this.isLoading = true,
    this.count,
    this.next,
    this.previous,
    this.page = 1,
    this.maxIndex,
    this.error,
    this.errorMessage,
  });

  final List<Notification>? notification;
  final bool isLoaded;
  final bool isLoading;
  final int? count;
  final String? next;
  final String? previous;
  final int page;
  final bool? maxIndex;
  final NetworkExceptions? error;
  final String? errorMessage;

  @override
  List<Object?> get props => [
        notification,
        isLoaded,
        isLoading,
        count,
        next,
        previous,
        page,
        maxIndex,
        error,
        errorMessage,
      ];

  NotificationState copyWith({
    List<Notification>? notification,
    NetworkExceptions? error,
    bool? isLoading,
    bool? isLoaded,
    int? count,
    String? next,
    String? previous,
    int? page,
    bool? maxIndex,
    String? errorMessage,
  }) {
    return NotificationState(
      notification: notification ?? this.notification,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      isLoaded: isLoaded ?? this.isLoaded,
      count: count ?? this.count,
      next: next ?? this.next,
      page: page ?? this.page,
      previous: previous ?? this.previous,
      maxIndex: maxIndex ?? this.maxIndex,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
