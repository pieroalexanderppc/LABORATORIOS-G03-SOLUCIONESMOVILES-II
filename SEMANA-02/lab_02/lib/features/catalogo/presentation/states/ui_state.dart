abstract class UiState<T> {
  const UiState();
}

class UiStateLoading<T> extends UiState<T> {}

class UiStateSuccess<T> extends UiState<T> {
  final T data;
  const UiStateSuccess(this.data);
}

class UiStateEmpty<T> extends UiState<T> {}

class UiStateError<T> extends UiState<T> {
  final String message;
  final void Function() retry;
  const UiStateError(this.message, {required this.retry});
}
