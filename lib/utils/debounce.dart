import 'dart:async';
import 'dart:ui';

class Debounce {
  final int delay;
  Debounce({this.delay = 500});

  Timer? _debounce;

  void execute(VoidCallback callback) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(Duration(milliseconds: delay), callback);
  }

  void dispose() {
    _debounce?.cancel();
  }
}