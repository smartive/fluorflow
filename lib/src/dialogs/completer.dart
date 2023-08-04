typedef DialogCompleter<T> = void Function({bool? confirmed, T? result});

extension CompleterExtensions<T> on DialogCompleter<T> {
  void confirm([T? result]) => call(confirmed: true, result: result);
  void cancel([T? result]) => call(confirmed: false, result: result);
}
