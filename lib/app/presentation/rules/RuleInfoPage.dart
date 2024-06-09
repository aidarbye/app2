import 'package:flutter/material.dart';
import 'package:medimom/app/data/RuleViewData.dart';

import '../pack/ConstValue.dart';

class RuleInfoPage extends StatefulWidget {

  final RuleViewData rule;

  const RuleInfoPage({super.key, required this.rule});

  @override
  State<StatefulWidget> createState() {
    return _RuleInfoPage();
  }
}

class _RuleInfoPage extends State<RuleInfoPage> {

  int _expanded = -1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          color: const Color.fromRGBO(239, 239, 239, 1.0),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                padding: EdgeInsets.only(left: ConstValue.leftMarginS, right: ConstValue.rightMarginS, top: ConstValue.topMargin),
                width: double.infinity,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          width: 30,
                          height: 30,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            borderRadius: BorderRadius.circular(10),
                            child: const SizedBox(
                              width: 30,
                              height: 30,
                              child: Icon(
                                Icons.arrow_back_ios_rounded,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 14),
                          child: Text(
                            widget.rule.title,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.w600
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 14),
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        children: _getButtons(),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _getButtons() {
    List<Widget> buttons = [];
    for (int i = 0; i < widget.rule.rules.length; i++) {
      buttons.add(_getButton(widget.rule.rules[i], i));
    }
    return buttons;
  }

  Widget _getButton(RuleInfo rule, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          if (_expanded == index) {
            _expanded = -1;
          } else {
            _expanded = index;
          }
        });
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 14, right: 14),
            height: 50,
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 14),
                  child: rule.type == 0 ? const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 22,
                  ) : rule.type == 1 ? const Icon(
                    Icons.error,
                    color: Colors.amber,
                    size: 22,
                  ) : Container(
                    width: 18,
                    height: 18,
                    margin: const EdgeInsets.only(left: 3),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red
                    ),
                    child: const Icon(
                      Icons.close,
                      size: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  rule.name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w600
                  ),
                )
              ],
            ),
          ),
          if (_expanded == index)
            Container(
              padding: const EdgeInsets.only(bottom: 14, left: 24, right: 24),
              child: Text(
                rule.info,
                style: const TextStyle(
                  fontSize: 12,
                  fontFamily: 'Rubik',
                  color: Colors.black
                ),
              ),
            ),
          if (widget.rule.rules.length - 1 != index)
            Container(
              width: double.infinity,
              height: 1,
              color: Colors.black.withOpacity(0.2),
            )
        ],
      ),
    );
  }

}