import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String? _loggedInUser;

  String? get loggedInUser => _loggedInUser;

  bool get isLoggedIn => _loggedInUser != null;

  void loginUser(String user) {
    _loggedInUser = user;
    notifyListeners();
  }

  void logoutUser() {
    _loggedInUser = null;
    notifyListeners();
  }

  String? _resetName;
  String? _resetEmail;

  String? get resetName => _resetName;
  String? get resetEmail => _resetEmail;

  void setResetName(String name) {
    _resetName = name;
    notifyListeners();
  }

  void setResetEmail(String email) {
    _resetEmail = email;
    notifyListeners();
  }
}

