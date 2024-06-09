import 'package:flutter/material.dart';
import 'package:medimom/app/presentation/check_lists/check_list_calendart.dart';
import 'package:medimom/app/presentation/check_lists/models/check_list_model.dart';
import 'package:medimom/app/presentation/check_lists/util/check_list_notifier.dart';
import 'package:provider/provider.dart';

class CheckList extends StatefulWidget {
  const CheckList({super.key});
  @override
  State<CheckList> createState() => _CheckListState();
}

class _CheckListState extends State<CheckList> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Чек листы"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const NameBloc(
            title: "Первый триместер",
            colorOfBackground: Colors.orange,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 10),
            itemCount: CheckListModel.getFirstTrimester().length,
            itemBuilder: (context, index) {
              return CheckListItemWidget(
                model: CheckListModel.getFirstTrimester()[index],
                color: Colors.orange,
              );
            },
          ),
          const NameBloc(
            title: "Второй триместер",
            colorOfBackground: Colors.blue,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: CheckListModel.getSecondTrimester().length,
            itemBuilder: (context, index) {
              return CheckListItemWidget(
                model: CheckListModel.getSecondTrimester()[index],
                color: Colors.blue,
              );
            },
          ),
          const NameBloc(
            title: "Третий триместер",
            colorOfBackground: Colors.pinkAccent,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: CheckListModel.getThirdTrimester().length,
            itemBuilder: (context, index) {
              return CheckListItemWidget(
                model: CheckListModel.getThirdTrimester()[index],
                color: Colors.pinkAccent,
              );
            },
          ),
        ],
      ),
    );
  }
}

class CheckListItemWidget extends StatelessWidget {
  final CheckListModel model;
  final Color color;
  const CheckListItemWidget({
    super.key,
    required this.model,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CheckListSelectingNotifier>(
      builder: (context, value, _) {
        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              if (value.intList.contains(model.id)) {
                Provider.of<CheckListSelectingNotifier>(context, listen: false).removeInt(model.id);  
              } else {
                Provider.of<CheckListSelectingNotifier>(context, listen: false).addInt(model.id);
              }
            },
            child: Ink(
              padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 12),
              child: Row(
                children: [
                  Container(
                    height: 20,
                    width:  20,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 2,
                        color: color
                      )
                    ),
                    child: Center(
                      child: Container(
                        height: 10,
                        width:  10,
                        decoration: BoxDecoration(
                          color: 
                            value.intList.contains(model.id) 
                              ? color 
                              : Colors.white,
        
                          borderRadius: BorderRadius.circular(5),
                        )
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  
                  Expanded(child: Text(
                    model.title,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      decoration: value.intList.contains(model.id) ? TextDecoration.lineThrough : null,
                    ),
                  )),
        
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context, MaterialPageRoute(
                          builder:(context) {
                            return CheckListCalendar(
                              model: model,
                            );  
                          },
                          fullscreenDialog: true
                        )
                      );
                    },
                    child: Consumer<CheckListSelectingCalendarNotifier>(
                      builder: (context, value, child) {
                        return SizedBox(
                          height: 24,
                          width: 24,
                          child: Center(
                            child: Icon(
                              Icons.edit_calendar_outlined,
                              color: 
                                value.intList.contains(model.id) ? Colors.green : Colors.black,
                            ),
                          ),
                        );
                      },
                    )
                  )
                ],
              ),
            ),
          )
        );
      },
    );
  }
}

class NameBloc extends StatelessWidget {
  final String title;
  final Color colorOfBackground;
  final Color textColor;

  const NameBloc({
    super.key,
    required this.title,
    required this.colorOfBackground,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 18),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(30)
        ),
        color: colorOfBackground
      ),
      child: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontSize: 20,
          fontWeight: FontWeight.w600
        ),
      ),
    );
  }
}