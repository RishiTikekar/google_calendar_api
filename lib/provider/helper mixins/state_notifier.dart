import 'package:flutter/foundation.dart';

enum States {
  none,
  loading,
  success,
  empty,
  error;
}

mixin StateNotifier on ChangeNotifier {
  // currentState = States.loading;

  States _currentState = States.none;

  States get currentState => _currentState;

  set currentState(States state) {
    _currentState = state;
    notifyListeners();
  }

  bool get isLoading => _currentState == States.loading;
}
