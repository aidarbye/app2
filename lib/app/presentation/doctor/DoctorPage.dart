import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medimom/app/domain/api/doctor.dart';
import 'package:medimom/app/domain/api/favorite.dart';
import 'package:medimom/app/domain/dto/doctor/response/CreateOrderRequest.dart';
import 'package:medimom/app/domain/dto/doctor/response/DoctorResponse.dart';
import 'package:medimom/app/presentation/pack/ConstValue.dart';
import 'package:medimom/app/presentation/pack/HeaderText.dart';
import 'package:medimom/app/presentation/pack/MessageHint.dart';
import 'package:medimom/app/presentation/pack/PrimaryButton.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorPage extends StatefulWidget {
  final DoctorResponse doctorData;
  const DoctorPage({super.key, required this.doctorData});
  @override
  State<StatefulWidget> createState() {
    return _DoctorPage();
  }
}

class _DoctorPage extends State<DoctorPage> {

  final _doctorAPI = DoctorAPI();
  final _favoriteAPI = FavoriteAPI();

  final List<String> _times = ["11:00", "12:00", "13:00", "14:00", "15:00", "16:00", "17:00"];
  List<String> _days = [];
  
  late bool _isFavorite;
  int _selectedTimeIndex = 0;
  int _selectedDayIndex = 0;

  late bool isEnabled;

  void _favoriteClicked() {
    if (_isFavorite) {
      _favoriteAPI.removeDoctor(widget.doctorData.doctor.id);
      setState(() {
        _isFavorite = false;
      });
    } else {
      _favoriteAPI.addDoctor(widget.doctorData.doctor.id);
      setState(() {
        _isFavorite = true;
      });
    }
  }

  @override
  void initState() {
    _isFavorite = widget.doctorData.isFavorite;
    final dt = DateTime.now();

    final int curDay = dt.day ~/ 7;

    isEnabled = true;

    // if (curDay == 1 || curDay == 2) {
    //   isEnabled = false;
    // } else {
    //   isEnabled = true;
    // }

    if (curDay == 1) {
      _days = ["ПН", "ВТ", "СР", "ЧТ", "ПТ",];
    } else if (curDay == 2){
      _days = ["ВТ", "СР", "ЧТ", "ПТ",];
    } else if (curDay == 3){
      _days = ["СР", "ЧТ", "ПТ",];
    } else if (curDay == 4){
      _days = ["ЧТ", "ПТ",];
    } else if (curDay == 5){
      _days = ["ПТ",];
    } else {
      _days = [];
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Padding(
                padding: EdgeInsets.only(left: ConstValue.leftMarginS, right: ConstValue.rightMarginS, top: ConstValue.topMargin),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 40,
                      child: Stack(
                        children: [
                          const Center(
                            child: HeaderText(
                                text: "Данные врача"
                            ),
                          ),
                          Row(
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
                              Expanded(child: Container()),
                              Container(
                                margin: const EdgeInsets.only(top: 5),
                                width: 30,
                                height: 30,
                                child: InkWell(
                                  onTap: () {
                                    _favoriteClicked();
                                  },
                                  borderRadius: BorderRadius.circular(10),
                                  child: SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: Icon(
                                      _isFavorite ? Icons.favorite : Icons.favorite_border,
                                      color: const Color.fromRGBO(249, 126, 134, 1),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      height: 115,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              widget.doctorData.doctor.imageUrl,
                              width: 115,
                              height: 115,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(left: 14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          widget.doctorData.doctor.name,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontFamily: 'Rubik'
                                          ),
                                        ),
                                      ),
                                      
                                      const SizedBox(width: 4),
        
                                      const Icon(
                                        Icons.star,
                                        color: Color.fromRGBO(0, 194, 8, 1),
                                        size: 16,
                                      ),
                                      Text(
                                        widget.doctorData.doctor.rating,
                                        style: const TextStyle(
                                            color: Color.fromRGBO(0, 194, 8, 1),
                                            fontSize: 12,
                                            fontFamily: 'Rubik',
                                            fontWeight: FontWeight.w600
                                        ),
                                      )
                                    ],
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 2),
                                    child: Text(
                                      widget.doctorData.doctor.type.name,
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.6),
                                          fontSize: 14,
                                          fontFamily: 'Rubik'
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            if (await canLaunchUrl(Uri.parse(widget.doctorData.doctor.clinic.clinic.description))) {
                                              await launchUrl(Uri.parse(widget.doctorData.doctor.clinic.clinic.description));
                                            } 
                                          },
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.location_on_rounded,
                                                color: Colors.black.withOpacity(0.6),
                                                size: 14,
                                              ),
                                              const SizedBox(width: 4),
                                              Expanded(
                                                child: Text(
                                                  widget.doctorData.doctor.clinic.clinic.name,
                                                  style: TextStyle(
                                                      color: Colors.black.withOpacity(0.6),
                                                      fontSize: 14,
                                                      fontFamily: 'Rubik',
                                                      fontWeight: FontWeight.normal
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 40),
                      child: Text(
                        widget.doctorData.doctor.info,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontFamily: 'Rubik'
                        ),
                      ),
                    ),
        
                    const Spacer(),

                    if (!isEnabled)  
                      const Text(
                        "К сожалению записей на эту неделю уже не осталось",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      if (!isEnabled)  
                       const SizedBox(height: 30,),
                     

                    if (isEnabled)  
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
        
                      children: [
                        Text(
                          "Записаться на эту неделю",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "После того как вы выберете удобную для вас дату и время и нажимаете на кнопку “записаться”, вам должны позвонить чтобы подтвердить запись.",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.w400
                          ),
                        )
                      ],
                    ),
                    if (isEnabled)  
                    const SizedBox(height: 20,),
                    if (isEnabled)  
                    _dateSelector(),
                    if (isEnabled)  
                    _timeSelector(),
                    if (isEnabled)  
                    Container(
                      margin: const EdgeInsets.only(bottom: 40),
                      child: PrimaryButton(
                        text: "Записаться",
                        onPressed: () async {
                          try {
                          await _doctorAPI.createOrder(
                            CreateOrderRequest(
                              dateTime: _selectedDayIndex * 10 + _selectedTimeIndex,
                              doctorId: widget.doctorData.doctor.id
                            )
                          ).then(
                            (value) {
                              showDialog(
                                context: context, 
                                builder:(context) {
                                  return const SuccessWidget();
                                },
                              ).then((value) => Navigator.of(context).pop());
                            }
                          );
                          // MessageHint.showMessage("Вы успешно записались к врачу!");
                          } catch (e) {
                            MessageHint.showMessage("Error ${e.toString()}");
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
      )
          
   
    );
  }

  Widget _dateSelector() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        height: 60,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: List.generate(_days.length, (index) => _dayWidget(index, _days[index])),
        ),
      ),
    );
  }

  Widget _timeSelector() {
    return Container(
      height: 40,
      margin: const EdgeInsets.only(bottom: 14),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(_times.length, (index) => _timeWidget(index, _times[index])),
      ),
    );
  }

  Widget _timeWidget(int index, String value) {
    return Container(
      margin: const EdgeInsets.only(right: 14),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedTimeIndex = index;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: _selectedTimeIndex == index ? const Color.fromRGBO(249, 126, 134, 1) : Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(12.0)),
            border: Border.all(
                color: const Color.fromRGBO(249, 126, 134, 1)
            )
          ),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Text(
            value,
            style: TextStyle(
              color: _selectedTimeIndex == index ? Colors.white : const Color.fromRGBO(249, 126, 134, 1),
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'Inter'
            ),
          ),
        ),
      ),
    );
  }

  Widget _dayWidget(int index, String value) {
    return Container(
      margin: const EdgeInsets.only(right: 14),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedDayIndex = index;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: _selectedDayIndex == index 
              ? const Color.fromRGBO(249, 126, 134, 1) 
              : Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(12.0)),
            border: Border.all(
              color: const Color.fromRGBO(249, 126, 134, 1)
            )
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Text(
            value,
            style: TextStyle(
              color: _selectedDayIndex == index ? Colors.white : const Color.fromRGBO(249, 126, 134, 1),
              fontSize: 18,
              fontWeight: FontWeight.w600,
              fontFamily: 'Inter'
            ),
          ),
        ),
      ),
    );
  }

}

class SuccessWidget extends StatelessWidget {
  const SuccessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        surfaceTintColor: Colors.white,
        // color: Colors.transparent,
        content: Padding(
          // margin: const EdgeInsets.only(top: 200,bottom: 200,left: 20,right: 20),
          padding: const EdgeInsets.only(top: 30,bottom: 20,left: 20,right: 20),
          // decoration: BoxDecoration(
          //   color: Colors.white,
          //   borderRadius: BorderRadius.circular(20)
          // ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/images/sucpic.png"
              ),
              const SizedBox(height: 20),
              const Text(
                "Вы успешно записались",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Вы успешно записались на прием, для подробной информации просмотрите вкладку записи",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(true);
                },
                child: Container(
                  width: 200,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: const Color(0xffF97E86),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: const Center(
                    child: Text("Продолжить",style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600
                    ),),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}