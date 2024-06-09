import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class MapNotifier extends ChangeNotifier {
  Map<String, String> _data = {};

  Map<String, String> get data => _data;

  MapNotifier() {
    _loadFromPrefs();
  }

  void addItem(String key, String value) {
    _data[key] = value;
    _saveToPrefs();
    notifyListeners();
  }

  void removeItem(String key) {
    _data.remove(key);
    _saveToPrefs();
    notifyListeners();
  }

  void _loadFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? dataString = prefs.getString('mapData');

    if (dataString != null) {
      _data = Map<String, String>.from(json.decode(dataString));
      notifyListeners();
    }
  }

  void _saveToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('mapData', json.encode(_data));
  }
}