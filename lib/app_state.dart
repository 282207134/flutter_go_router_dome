import 'package:flutter/foundation.dart';

class AppState extends ChangeNotifier {
  bool _isLoggedIn = false;
  String? _userName;

  bool get isLoggedIn => _isLoggedIn;

  String get userName => _userName ?? 'Go Router 学习者';

  void logIn(String name) {
    _isLoggedIn = true;
    _userName = name.isEmpty ? null : name;
    notifyListeners();
  }

  void logOut() {
    _isLoggedIn = false;
    _userName = null;
    notifyListeners();
  }
}
