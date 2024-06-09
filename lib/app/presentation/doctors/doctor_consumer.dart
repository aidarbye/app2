import 'package:flutter/material.dart';
import 'package:medimom/app/domain/api/favorite.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class DoctorMapNotifier with ChangeNotifier {
  Map<int, bool> _map = {};
  Map<int, bool> get map => _map;

  final _favoriteAPI = FavoriteAPI();

  DoctorMapNotifier() {
    _loadFromPrefs();
  }

  void addItem(int key, bool value) {
    _map[key] = value;
    _saveToPrefs();
    notifyListeners();
  }

  void removeItem(int key) {
    _map.remove(key);
    _saveToPrefs();
    notifyListeners();
  }

  bool getItem(int key) {
    return _map[key] ?? false;
  }

  void _saveToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('DoctorMapNotifier', json.encode(_map));
  }

  void _loadFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? mapString = prefs.getString('DoctorMapNotifier');
    if (mapString != null) {
      Map<String, dynamic> jsonMap = json.decode(mapString);
      _map = jsonMap.map((key, value) => MapEntry(int.parse(key), value));
      notifyListeners();
    }
  }
}