import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medimom/app/domain/api/babe.dart';
import 'package:medimom/app/domain/api/user.dart';
import 'package:medimom/app/domain/dto/babe/BabeResponse.dart';
import 'package:medimom/app/presentation/calendar/CalendarPage.dart';
import 'package:medimom/app/presentation/doctors/DoctorsPage.dart';
import 'package:medimom/app/presentation/hospitals/HospitalsPage.dart';
import 'package:medimom/app/presentation/opinion/opinion_page.dart';
import 'package:medimom/app/presentation/pack/ConstValue.dart';
import 'package:medimom/app/presentation/pack/MessageHint.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  late final BabeAPI _babeAPI = BabeAPI();
  late Future<BabeResponse> future = _babeAPI.getBabe();

  int? babyindex;
  int? id;
  
  @override
  void initState() {
    _babeAPI.getBabe().then((value) {
      id = value.userId;
      final index = extractNumber(value.age);
      log(index.toString());
      babyindex = index;
    });
    super.initState();
  }
  int extractNumber(String input) {
    RegExp regExp = RegExp(r'^\d+');
    Match? match = regExp.firstMatch(input);
    if (match != null) {
      return int.parse(match.group(0)!);
    } else {
      return 0;
    }
}


  void _changePage(Widget widget) {
    Navigator.push(context,MaterialPageRoute(builder: (_) => widget));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0, 0.5],
          colors: [Color.fromRGBO(249, 126, 134, 1), Colors.white],
        )
      ),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          Padding(
            padding: EdgeInsets.only(top: ConstValue.topMargin, left: ConstValue.leftMargin, right: ConstValue.rightMargin),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                
                FutureBuilder<BabeResponse>(
                  future: future, 
                  builder:(context, snapshot) {
                    if (snapshot.hasData) {
                      final model = snapshot.data;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,

                        children: [
                          const Text(
                            "Ваш малыш",
                            style: TextStyle(
                              fontSize: 26,
                              fontFamily: 'Rubik',
                              fontWeight: FontWeight.w700,
                              color: Colors.white
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Период беременности",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Rubik',
                              fontWeight: FontWeight.w600,
                              color: Colors.white
                            ),
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 50),
                                  child: Image.asset(
                                    "assets/images/baby_on_main.png"
                                  ),
                                ),
                                
                                Row(
                                  children: [
                                    BbayTextSquareWidget(
                                      title: "${model?.size}",
                                      subtitle: "гр.",
                                    ),
                                    const SizedBox(width: 20),
                                    Column(
                                      children: [
                                        const SizedBox(height: 80),
                                        BbayTextSquareWidget(
                                          title: "${model?.age}",
                                          subtitle: "недель",
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 20),
                                    BbayTextSquareWidget(
                                      title: "${model?.weight}",
                                      subtitle: "см.",
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 40),

                        ],
                      );
                    } if (snapshot.hasError) {
                      return BabyRegisterWidget(
                        id: id ?? 0,
                        callback: () {
                          setState(() {
                            future = _babeAPI.getBabe();
                          });
                          _babeAPI.getBabe().then((value) {
                            id = value.userId;
                            final index = extractNumber(value.age);
                            log(index.toString());
                            babyindex = index;
                          });
                        },
                      );
                    }
                    else {
                      return const SizedBox();
                    }
                  },
                ),
                
                Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    MenuButton(
                      title: "Врачи",
                      assetPath: "assets/images/doctor.png",
                      callback: () {
                        _changePage(const DoctorsPage());
                      },
                    ),
                    MenuButton(
                      title: "Клиника",
                      assetPath: "assets/images/hospital.png",
                      callback: () {
                        _changePage(const HospitalsPage());
                      },
                    ),
                    MenuButton(
                      title: "Календарь",
                      assetPath: "assets/images/calendar.png",
                      callback: () {
                        _changePage(CalendarPage(
                          index: babyindex,
                        ));
                      },
                    ),
                    MenuButton(
                      title: "Советы",
                      assetPath: "assets/images/opinion.png",
                      callback: () {
                        _changePage(const OpinionPage());
                      },
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class BabyRegisterWidget extends StatelessWidget {
  final int id;
  const BabyRegisterWidget({
    super.key,
    required this.callback,
    required this.id,
  });
  final Function callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context, 
          MaterialPageRoute(
            fullscreenDialog: true,
            builder:(context) {
              return BabyCreateWidget(
                id: id,
              );
            },
          )
        ).then((value) => callback.call());
      },
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
      
        children: [
          Text(
            "Данные малыша",
            style: TextStyle(
              fontSize: 26,
              fontFamily: 'Rubik',
              fontWeight: FontWeight.w700,
              color: Colors.white
            ),
          ),
          SizedBox(height: 10),
          Text(
            "У вас отсутсвуют данные о малыше",
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Rubik',
              fontWeight: FontWeight.w600,
              color: Colors.white
            ),
          ),
          SizedBox(height: 20),
          Text(
            "Вы можете добавить данные о вашем малыше чтобы они отображались на главном экране",
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Rubik',
              fontWeight: FontWeight.w500,
              color: Colors.white
            ),
          ),
          SizedBox(height: 40),
      
        ],
      ),
    );
  }
}

class BabyCreateWidget extends StatefulWidget {
  final int id;
  const BabyCreateWidget({super.key,required this.id});
  @override
  State<BabyCreateWidget> createState() => _BabyCreateWidgetState();
}

class _BabyCreateWidgetState extends State<BabyCreateWidget> {
  final _formKey = GlobalKey<FormState>();
  late final BabeAPI _babeAPI = BabeAPI();

  final TextEditingController first = TextEditingController();
  final TextEditingController second = TextEditingController();
  final TextEditingController third = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Добавление малыша"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Возраст',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: first,
                decoration: const InputDecoration(
                  hintText: 'Введите возраст',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите значение';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'Размер',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: third,
                decoration: const InputDecoration(
                  hintText: 'Введите размер',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите значение';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'Вес',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: second,
                decoration: const InputDecoration(
                  hintText: 'Введите размер',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите значение';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () async {
                  try {
                  if (_formKey.currentState?.validate() ?? false) {
                    num? id = 0;
                    await UserAPI().checkProfile().then((value) {
                       id = value.id;
                    });
                    log(id.toString());
                    _babeAPI.createBabe(
                      age: first.text, 
                      weight: second.text, 
                      size: third.text, 
                      id: (id ?? 0)
                    ).then((value) => Navigator.of(context).pop());
                  }
                  } catch (e) {
                    MessageHint.showMessage(e.toString());
                  }   
                },
                child: const Text(
                  'Подтвердить',
                  style: TextStyle(
                    color: Colors.black
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}

class BbayTextSquareWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  const BbayTextSquareWidget({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        maxWidth: (MediaQuery.of(context).size.width / 3) - 35
      ),
      padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 30,
                fontFamily: 'Rubik',
                fontWeight: FontWeight.w500,
                height: 1.4,
                color: Color(0xffF97E86)
              ),
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Rubik',
              fontWeight: FontWeight.w400,
              height: 1.2,
              color: const Color(0xffF97E86).withOpacity(0.6)
            ),
          ),
        ],
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final String title;
  final String assetPath;
  final Function callback;
  const MenuButton({
    super.key,
    required this.title,
    required this.assetPath,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,constraints) {
        return Material(
          color: Colors.transparent,
          shadowColor: Colors.black,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              callback.call();
            },
            
            child: Container(
              height: (constraints.maxWidth / 2) - 10,
              width: (constraints.maxWidth / 2) - 10,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.1), // 15% opacity
                    offset: Offset(4, 6), // X: 0, Y: 2
                    blurRadius: 20,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      assetPath,
                      width: constraints.maxWidth / 4,
                      height: constraints.maxWidth / 5,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Rubik',
                        color: Colors.black.withOpacity(0.6)
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            ),
            
          ),
        );
      }
    );
  }
}

