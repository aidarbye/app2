import 'package:flutter/material.dart';
import 'package:medimom/app/presentation/checklist/utils/checklistnotifier.dart';
import 'package:medimom/app/presentation/pack/ConstValue.dart';
import 'package:medimom/app/presentation/pack/HeaderText.dart';
import 'package:medimom/app/presentation/pack/SimpleText.dart';
import 'package:medimom/app/presentation/pack_to/PackToPage.dart';
import 'package:medimom/app/presentation/rules/RulesPage.dart';
import 'package:provider/provider.dart';

class CheckListPage extends StatefulWidget {

  const CheckListPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CheckListPage();
  }
}

class _CheckListPage extends State<CheckListPage> {

  void _changePage(Widget widget) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: ConstValue.leftMarginS, right: ConstValue.rightMarginS, top: ConstValue.topMargin),
      width: double.infinity,
      decoration: const BoxDecoration(
          color: Colors.white
      ),
      child: Column(
        children: [
          const HeaderText(
            text: "Помощник",
          ),
          Container(
            margin: const EdgeInsets.only(top: 13),
            child: InkWell(
              onTap: () {
                _changePage(const PackToPage());
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(249, 126, 134, 1),
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: const Icon(
                      Icons.backpack,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SimpleText(text: "Сумка", color: Colors.black, size: 14),
                      SimpleText(text: "Сумка в роддом, что нужно", color: Colors.black.withOpacity(0.6), size: 12),
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 13),
            child: InkWell(
              onTap: () {
                _changePage(const RulesPage());
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(249, 126, 134, 1),
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: const Icon(
                      Icons.emoji_food_beverage_outlined,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SimpleText(text: "Что можно и нельзя", color: Colors.black, size: 14),
                      SimpleText(text: "Что можно и нельзя во время беременности", color: Colors.black.withOpacity(0.6), size: 12),
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 13),
            child: InkWell(
              onTap: () {
                _changePage(const ZametkiPage());
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(249, 126, 134, 1),
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: const Icon(
                      Icons.feed,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SimpleText(text: "Дневник беременной", color: Colors.black, size: 14),
                      SimpleText(text: "Ваши небольшие заметки", color: Colors.black.withOpacity(0.6), size: 12),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ZametkiPage extends StatefulWidget {
  const ZametkiPage({super.key});
  @override
  State<ZametkiPage> createState() => _ZametkiPageState();
}

class _ZametkiPageState extends State<ZametkiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Заметки"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder:(context) {
                    return const CreateNotePage();
                  },
                )
              );
            }, 
            icon: const Icon(Icons.add)
          )
        ],
      ),
      body: Consumer<MapNotifier>(
        builder: (context, value, child) {
          return ListView.separated(
            padding: const EdgeInsets.all(20),
            shrinkWrap: true,
            itemBuilder:(context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return NotePage(
                          text: value.data.values.toList()[index].toString(),
                        );
                      },
                    )
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration:  BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: const Offset(0, 2),
                        blurRadius: 50,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Text(
                    value.data.values.toList()[index].toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              );
            }, 
            separatorBuilder:(context, index) {
              return const SizedBox(height: 20);
            }, 
            itemCount: value.data.keys.length
          );
        },  
      ),
    );
  }
}

class NotePage extends StatelessWidget {
  final String text;
  const NotePage({super.key,required this.text});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Заметка"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }
}

class CreateNotePage extends StatefulWidget {
  const CreateNotePage({super.key});
  @override
  State<CreateNotePage> createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  late final TextEditingController textEditingController = TextEditingController();
  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }
  static const double _widthOfBorder = 0.01;
  static const Color  _colorOfBorder = Colors.transparent;
  static const double _raduisOfBorder = 22;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Создание заметки"),
      ),
      body: Column(
        children: [
          Expanded(
          child: TextFormField(
            maxLines: null,
            autocorrect: true,
            enableSuggestions: true,
            autofocus: false,
            controller: textEditingController,

            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
            cursorColor: Colors.blue,
            decoration: InputDecoration(
              filled: true,
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 14,vertical: 10),        
              fillColor: Colors.white,
              hintText: "Начните вводить заметку",
              hintStyle: const TextStyle(
                color: Color.fromARGB(255, 72, 72, 72),
                fontWeight: FontWeight.w400,
              ),
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: _colorOfBorder,
                  width: _widthOfBorder
                ),
                borderRadius: BorderRadius.circular(_raduisOfBorder),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: _colorOfBorder,
                  width: _widthOfBorder
                ),
                borderRadius: BorderRadius.circular(_raduisOfBorder),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: _colorOfBorder,
                  width: _widthOfBorder
                ),
                borderRadius: BorderRadius.circular(_raduisOfBorder),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: _colorOfBorder,
                  width: _widthOfBorder
                ),
                borderRadius: BorderRadius.circular(_raduisOfBorder),
              ),
            ),
          ),
        ),
          GestureDetector(
            onTap: () {
              if (textEditingController.text.trim().isNotEmpty) {
                Provider.of<MapNotifier>(context,listen: false).addItem(
                  textEditingController.text.trim(), 
                  textEditingController.text.trim()
                );
                Navigator.of(context).pop();
              }
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 30),
              decoration: const BoxDecoration(
                color: Colors.green
              ),
              child: const Center(child: Text(
                "Создать",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600
                ),
              )),
            ),
          )
        ],
      ),
    );
  }
}