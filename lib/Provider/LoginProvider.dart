import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  String _number = '';

  String get number => _number;

  LoginProvider() {
    _loadFromPreferences();
  }

  void _loadFromPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _number = prefs.getString('number') ?? '';
    notifyListeners();
  }

  void updateNumber(String newNumber) async {
    _number = newNumber;
    notifyListeners();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('number', newNumber);
  }
}
