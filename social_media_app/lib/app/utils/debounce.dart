import 'dart:async';

/// Debounces a function and returns a new function that will only execute the
/// original function if [duration] time has passed without another call to
/// the returned function.
///
/// Example usage:
///
/// ```dart
/// final debouncedFunction = debounce((String value) {
///   print('Search query: $value');
/// }, duration: Duration(milliseconds: 500));
///
/// // Call debouncedFunction multiple times quickly
/// debouncedFunction('a');
/// debouncedFunction('ab');
/// debouncedFunction('abc');
///
/// // Only the last call will actually trigger the function after 500ms
/// ```
Function debounce(Function function, {Duration duration = const Duration(milliseconds: 300)}) {
  Timer? timer;

  return () {
    timer?.cancel();
    timer = Timer(duration, () {
      function();
    });
  };
}
