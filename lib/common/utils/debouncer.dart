import 'dart:async';

class Debouncer {
  Debouncer({this.timerDuration = const Duration(seconds: 1)});

  Timer? _timer;
  final Duration timerDuration;

  void resetDebounce(void Function() execute) {
    _timer?.cancel();
    _timer = Timer(timerDuration, execute);
  }

  void dispose() {
    _timer?.cancel();
    _timer = null;
  }
}
