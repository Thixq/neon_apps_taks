import 'dart:async';

import 'package:flutter/cupertino.dart';

class NotificationCenter extends ChangeNotifier {
  final decodePassword = 'Neon Apps';
  int progress = 0;
  bool progressed = false;
  Timer? _timer;
  void startDecoding() {
    _timer?.cancel();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      progress++;
      if (progress == 15) {
        timer.cancel();
        progressed = true;
      }
      notifyListeners();
    });
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
    notifyListeners();
  }
}
