import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FavoritesProvider with ChangeNotifier {
  String loginId;
  Map<String, List<Map<String, dynamic>>> _favorites = {};

  FavoritesProvider(this.loginId) {
    _loadFavorites();
  }

  List<Map<String, dynamic>> get favorites {
    return _favorites[loginId] ?? [];
  }

  void toggleFavorite(Map<String, dynamic> university) async {
    if (_favorites[loginId] == null) {
      _favorites[loginId] = [];
    }

    if (favorites.any((fav) => fav['name'] == university['name'])) {
      // Remove from favorites
      _favorites[loginId]!.removeWhere((fav) => fav['name'] == university['name']);
    } else {
      // Add to favorites
      _favorites[loginId]!.add(university);
    }

    notifyListeners();
    await _saveFavorites();
  }

  bool isFavorite(String name) {
    return favorites.any((fav) => fav['name'] == name);
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('favorites') ?? '{}';
    _favorites = Map<String, List<Map<String, dynamic>>>.from(
      (data.isEmpty ? {} : Map<String, dynamic>.from(jsonDecode(data)))
          .map((key, value) => MapEntry(
        key,
        List<Map<String, dynamic>>.from(value),
      )),
    );
    notifyListeners();
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final data = jsonEncode(_favorites);
    await prefs.setString('favorites', data);
  }
}
