import 'package:flutter/material.dart';
import 'package:medimom/app/presentation/pack/ConstValue.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PackToPage extends StatefulWidget {

  const PackToPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PackToPage();
  }
}

class _PackToPage extends State<PackToPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: const Color.fromRGBO(239, 239, 239, 1.0),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              padding: EdgeInsets.only(left: ConstValue.leftMarginS, right: ConstValue.rightMarginS, top: ConstValue.topMargin, bottom: 40),
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
                        child: const Text(
                          "Список вещей в роддом",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'Rubik',
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 14),
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "На основании эффективных перинатальных  технологий по   рекомендации ВОЗ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Rubik'
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 6),
                          child: const Text(
                            "Документы:",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                        const SwitchListTileWidget(
                          title: "1. Обменная карта",
                        ),
                        const SwitchListTileWidget(
                          title: "2. Удостоверение личности (оргинал+ксерокопия)",
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 6),
                          child: const Text(
                            "Список вещей в роддом для мамы:",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                        const SwitchListTileWidget(
                          title: "1. Халат (1 шт)",
                        ),
                        const SwitchListTileWidget(
                          title: "2. Сорочка (1-2 шт.)",
                        ),
                        const SwitchListTileWidget(
                          title: "3. Тапочки (1 пара)",
                        ),
                        const SwitchListTileWidget(
                          title: "4. Урологические прокладки  (1 уп.)",
                        ),
                        const SwitchListTileWidget(
                          title: "5. Туалетные принадлежности (зубная паста, зубная щетка, жидкое мыло)",
                        ),
                        const SwitchListTileWidget(
                          title: "6. Туалетная бумага",
                        ),
                        const SwitchListTileWidget(
                          title: "7. Полотенце",
                        ),
                        const SwitchListTileWidget(
                          title: "8. Влажные салфетки (1 упаковка)",
                        ),
                        const SwitchListTileWidget(
                          title: "9. Вода без газа (1,5 л)",
                        ),
                        const SwitchListTileWidget(
                          title: "10. По желаниию постельное белье",
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 6),
                          child: Text(
                            "На кесарево сечение дополнительно:",
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.8),
                                fontSize: 14,
                                fontFamily: 'Rubik',
                            ),
                          ),
                        ),
                        const SwitchListTileWidget(
                          title: "1. компрессионные чулки (2шт.) ",
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 6),
                          child: const Text(
                            "Список вещей для ребенка:",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                        const SwitchListTileWidget(
                          title: "1. Пеленки – 4 шт(2 тонкие+2 флонелиевые)",
                        ),
                        const SwitchListTileWidget(
                          title: "2. Полотенце большое махрововое для новорожденного (или плед)",
                        ),
                        const SwitchListTileWidget(
                          title: "3. Распашонка – 1шт теплая",
                        ),
                        const SwitchListTileWidget(
                          title: "4. Ползунки х/б – 1 шт.",
                        ),
                        const SwitchListTileWidget(
                          title: "5. Шапочки х/б – 2 шт. (теплая и тонкая, желательно лыжные)",
                        ),
                        const SwitchListTileWidget(
                          title: "6. Носочки – 2 пары",
                        ),
                        const SwitchListTileWidget(
                          title: "7. Влажные салфетки – 1 уп.",
                        ),
                        const SwitchListTileWidget(
                          title: "8. Памперсы №1 (для новорожденных ) – 2 шт.",
                        ),
                        const SwitchListTileWidget(
                          title: "10. По желанию постельное белье",
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 6),
                          child: const Text(
                            "Все вещи для новорожденного необходимо предварительно постирать и прогладить.",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SwitchListTileWidget extends StatefulWidget {
  final String title;
  const SwitchListTileWidget({super.key,required this.title});
  @override
  State<SwitchListTileWidget> createState() => _SwitchListTileState();
}

class _SwitchListTileState extends State<SwitchListTileWidget> {
  bool sValue = false;

  @override
  void initState() {
    super.initState();
    _loadFromPrefs();
  }

  void _loadFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      sValue = prefs.getBool(widget.title) ?? false;
    });
  }

  void _saveToPrefs(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(widget.title, value);
  }


  @override
  Widget build(BuildContext context) {
    return SwitchListTile.adaptive(
      dense: true,
      onChanged: (val) {
        setState(() {
          sValue = val;
          _saveToPrefs(sValue);
        });
      },
      title: Text(
        widget.title,
        style: TextStyle(
          color: Colors.black.withOpacity(0.8),
          fontSize: 16,
          fontFamily: 'Rubik',
        ),
      ),
      value: sValue,
    );
  }
}