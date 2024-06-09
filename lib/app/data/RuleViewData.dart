import 'package:flutter/cupertino.dart';

class RuleViewData {

  IconData icon;
  String title;
  List<RuleInfo> rules;

  RuleViewData({
    required this.icon,
    required this.title,
    required this.rules,
  });
}

class RuleInfo {
  int type;
  String name;
  String info;

  RuleInfo({
    required this.type,
    required this.name,
    required this.info,
  });
}