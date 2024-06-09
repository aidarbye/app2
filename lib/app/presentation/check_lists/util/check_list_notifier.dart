import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckListSelectingNotifier extends ChangeNotifier {
  List<int> _intList = [];

  List<int> get intList => _intList;

  void _loadFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? stringList = prefs.getStringList('selectNotifierCL');
    if (stringList != null) {
      _intList = stringList.map((e) => int.parse(e)).toList();
      notifyListeners();
    }
  }

  CheckListSelectingNotifier() {
    _loadFromPrefs();
  }

  void _saveToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('selectNotifierCL', _intList.map((e) => e.toString()).toList());
  }

  void addInt(int value) {
    _intList.add(value);
    _saveToPrefs();
    notifyListeners();
  }

  void removeInt(int value) {
    _intList.remove(value);
    _saveToPrefs();
    notifyListeners();
  }

  void clearList() {
    _intList.clear();
    _saveToPrefs();
    notifyListeners();
  }
}

class CheckListSelectingCalendarNotifier extends ChangeNotifier {
  List<int> _intList = [];

  List<int> get intList => _intList;

  void _loadFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? stringList = prefs.getStringList('selectNotifierCN');

    if (stringList != null) {
      _intList = stringList.map((e) => int.parse(e)).toList();
      notifyListeners();
    }
  }

  CheckListSelectingCalendarNotifier() {
    _loadFromPrefs();
  }

  void addInt(int value) {
    _intList.add(value);
    _saveToPrefs();
    notifyListeners();
  }

  void removeInt(int value) {
    _intList.remove(value);
    _saveToPrefs();
    notifyListeners();
  }

  void _saveToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('selectNotifierCN', _intList.map((e) => e.toString()).toList());
  }
}

class CheckListSelectingCalendarWithNotifyNotifier extends ChangeNotifier {
  List<int> ids = [];
  Map<int, String?> mapOfDates = {};

  CheckListSelectingCalendarWithNotifyNotifier() {
    _loadFromPrefs();
  }

  void _loadFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? intStringList = prefs.getStringList('nId');
    String? mapOfDatesIn = prefs.getString("mapOfDates");

    if (mapOfDatesIn != null) {
      Map<String, dynamic> tempMap = jsonDecode(mapOfDatesIn);
      mapOfDates = tempMap.map((key, value) => MapEntry(int.parse(key), value as String?));
    }

    if (intStringList != null) {
      ids = intStringList.map((e) => int.parse(e)).toList();
    }

    notifyListeners();
  }

  void addInt(int value) {
    ids.add(value);
    _saveToPrefs();
    notifyListeners();
  }

  void removeInt(int value) {
    ids.remove(value);
    mapOfDates.remove(value);
    _saveToPrefs();
    notifyListeners();
  }

  Future addToMap(int id, String value) async {
    mapOfDates[id] = value;
    await _saveToPrefs();
    notifyListeners();
  }

  void removeFromMap(int id) {
    mapOfDates.remove(id);
    _saveToPrefs();
    notifyListeners();
  }

  Future _saveToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('nId', ids.map((e) => e.toString()).toList());
     prefs.setString('mapOfDates', jsonEncode(mapOfDates.map((key, value) => MapEntry(key.toString(), value ?? ''))));
  }
}