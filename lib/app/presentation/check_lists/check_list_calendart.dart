import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medimom/app/presentation/check_lists/models/check_list_model.dart';
import 'package:medimom/app/presentation/check_lists/util/check_list_notifier.dart';
import 'package:medimom/app/presentation/check_lists/util/notification_service.dart';
import 'package:provider/provider.dart';

class CheckListCalendar extends StatefulWidget {
  final CheckListModel model;
  const CheckListCalendar({super.key,required this.model});
  @override
  State<CheckListCalendar> createState() => _CheckListCalendarState();
}

class _CheckListCalendarState extends State<CheckListCalendar> {
  late String selectedDate;
  late bool isNotify;

  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }

  DateTime parseDate(String date) {
    if (date == "Сейчас") {
      return DateTime.now();
    }
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.parse(date);
  }

  @override
  void initState() {
    selectedDate = Provider.of<CheckListSelectingCalendarWithNotifyNotifier>(context, listen: false).mapOfDates[widget.model.id] ?? "Сейчас";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 12,left: 12),
              child: Text(
                widget.model.title,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.blueGrey
                ),
              ),
            ),

            const Divider(),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      "Запланировать",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black
                      ),
                    ),
                  ),  
                  Consumer<CheckListSelectingCalendarNotifier>(
                    builder: (context, value, child) {
                      return Switch.adaptive(
                        value: value.intList.contains(widget.model.id), 
                        onChanged: (value) {
                          if (value) {
                            Provider.of<CheckListSelectingCalendarNotifier>(context, listen: false).addInt(widget.model.id);  
                          } else {
                            Provider.of<CheckListSelectingCalendarNotifier>(context, listen: false).removeInt(widget.model.id);  
                          }
                        }
                      );
                    },
                  )
                ],
              ),
            ),

            const Divider(),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "Дата",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black
                        ),
                      ),
                    ),  
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          showDatePicker(
                            context: context, 
                            firstDate: DateTime.now(), 
                            initialDate: parseDate(selectedDate),
                            lastDate: DateTime(2025),
                            initialEntryMode: DatePickerEntryMode.calendarOnly,
                            locale: const Locale("ru","RU")
                          ).then(
                            (value) {
                              if (value != null) {
                                setState(() {
                                  selectedDate = formatDate(value);
                                });
                              }
                            }
                          );
                        },
                        child: Text(
                          selectedDate,  
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),  
                  ],
                ),
              ),
            ),

            const Divider(),

            if (selectedDate == "Сейчас")
              Opacity(
                opacity: 0.5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Напомнить",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black
                          ),
                        ),
                      ),  
                      Switch.adaptive(
                        value:false,
                        onChanged: (val) {},
                      )
                    ],
                  ),
                ),
              )
            else 
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "Напомнить",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black
                        ),
                      ),
                    ),  
                    Switch.adaptive(
                      value: Provider.of<CheckListSelectingCalendarWithNotifyNotifier>(context,listen: true).ids.contains(widget.model.id),
                      onChanged: (val) {
                        if (val) {
                          Provider.of<CheckListSelectingCalendarWithNotifyNotifier>(context, listen: false).addInt(widget.model.id);  
                        } else {
                          Provider.of<CheckListSelectingCalendarWithNotifyNotifier>(context, listen: false).removeInt(widget.model.id);  
                        }
                      },
                    )
                  ],
                ),
              ),
              

            const Spacer(),

            InkWell(
              onTap: () async {
                if (selectedDate != "Сейчас") {
                  await Provider
                    .of<CheckListSelectingCalendarWithNotifyNotifier>
                      (context, listen: false).addToMap(
                        widget.model.id, 
                        selectedDate
                      );  
                  if (
                  Provider.of<CheckListSelectingCalendarWithNotifyNotifier>
                      (context, listen: false).ids.contains(widget.model.id)) {
                        NotificationService.instance.createLocalNotify(
                          widget.model.id, 
                          widget.model.title, 
                          parseDate(selectedDate)
                        );
                    }
                } else {
                  NotificationService.instance.cancelLocalNotification(
                    widget.model.id, 
                  );
                }
                Navigator.of(context).pop();
              },
              child: Ink(
                padding: const EdgeInsets.only(bottom: 50,top: 20),
                decoration: const BoxDecoration(
                  color: Colors.green,
                ),
                child: const Center(
                  child: Text(
                    "Сохранить",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),

                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}