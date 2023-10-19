import 'package:flutter/material.dart';
import 'package:futter_stable/user_model.dart';

class UserProvider extends ChangeNotifier {
  User? _loggedInUser;

  User? get loggedInUser => _loggedInUser;

  bool get isLoggedIn => _loggedInUser != null;

  void loginUser(User user) {
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

