import 'package:flutter/material.dart';
import 'package:medimom/app/domain/api/doctor.dart';
import 'package:medimom/app/domain/dto/doctor/response/OrderResponse.dart';
import 'package:medimom/app/presentation/doctor/DoctorPage.dart';
import 'package:medimom/app/presentation/doctors/DoctorWidget.dart';
import 'package:medimom/app/presentation/pack/ConstValue.dart';
import 'package:medimom/app/presentation/pack/HeaderText.dart';

class OrdersPage extends StatefulWidget {

  const OrdersPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _OrdersPage();
  }
}

class _OrdersPage extends State<OrdersPage> {

  final List<String> _times = ["11:00", "12:00", "13:00", "14:00", "15:00", "16:00", "17:00"];
  final List<String> _days = ["ПН", "ВТ", "СР", "ЧТ", "ПТ"];
  final _doctorAPI = DoctorAPI();
  final List<OrderResponse> _orders = [];

  void _onLoaded(List<OrderResponse> orders) {
    setState(() {
      _orders.addAll(orders);
    });
  }

  void _loadOrders() {
    _doctorAPI.findAllOrders().then((value) => _onLoaded(value));
  }

  @override
  void initState() {
    _loadOrders();
    super.initState();
  }

  void _changePage(Widget widget) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          color: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                padding: EdgeInsets.only(left: ConstValue.leftMarginS, right: ConstValue.rightMarginS, top: ConstValue.topMargin),
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                      child: Stack(
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
                          const Center(
                            child: HeaderText(
                                text: "Приемы"
                            ),
                          )
                        ],
                      ),
                    ),
                    Column(
                      children: List.generate(_orders.length, (index) => Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DoctorWidget(
                                onClick: (doctor) {
                                  _changePage(DoctorPage(doctorData: doctor));
                                },
                                doctorData: _orders[index].doctorData
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(249, 126, 134, 1),
                                borderRadius: BorderRadius.circular(5)
                              ),
                              child: Text(
                                _orders[index].dateTime < 10 ? "${_days[0]}, ${_times[_orders[index].dateTime]}" : "${_days[int.parse(_orders[index].dateTime.toString()[0])]}, ${_times[int.parse(_orders[index].dateTime.toString()[1])]}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontFamily: 'Inter'
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
                    ),
                    Container(height: 20)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}