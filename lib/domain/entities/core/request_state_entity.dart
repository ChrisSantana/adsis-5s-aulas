import 'package:order_manager/core/enum/app_state_enum.dart';

abstract class IRequestState<T> {
  final T? dataOrNull;
  final Object? error;
  final AppStateEnum status;

  const IRequestState({
    required this.status,
    this.dataOrNull,
    this.error,
  });

  T get data => dataOrNull!;
}

final class RequestInitiationState<T> extends IRequestState<T> {
  final T? value;
  const RequestInitiationState({
    this.value,
  }) : super(dataOrNull: value, status: AppStateEnum.none);
}

final class RequestCompletedState<T> extends IRequestState<T> {
  final T? value;
  const RequestCompletedState({
    this.value,
  }) : super(dataOrNull: value, status: AppStateEnum.completed);
}

final class RequestProcessingState<T> extends IRequestState<T> {
  final T? value;
  const RequestProcessingState({
    this.value,
  }) : super(dataOrNull: value, status: AppStateEnum.processing);
}

final class RequestErrorState<T> extends IRequestState<T> {
  final T? value;
  const RequestErrorState({
    required super.error,
    this.value,
  }) : super(dataOrNull: value, status: AppStateEnum.error);
}
