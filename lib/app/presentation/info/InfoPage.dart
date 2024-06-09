// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:medimom/app/presentation/authorization/AuthorizationPage.dart';
import 'package:medimom/app/presentation/pack/ButtonText.dart';
import 'package:medimom/app/presentation/pack/ConstValue.dart';
import 'package:medimom/app/presentation/pack/PrimaryButton.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});
  @override
  State<StatefulWidget> createState() => _InfoPage();
}

class _InfoPage extends State<InfoPage> {
  void _changePage(Widget widget) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
  }

  void _nextInfo() {
    if (selectedIndex == 0) {
      _controller.animateToPage(
        1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn
      );
      setState(() {
        selectedIndex = 1;
      });
    } else {
      _changePage(const AuthorizationPage());  
    }
  }

  void _skipInfo() {
    _changePage(const AuthorizationPage());
  }

  late PageController _controller;
  
  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: ConstValue.topMargin, bottom: ConstValue.bottomMargin),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: PageView(
                  controller: _controller,
                  onPageChanged: (value) {
                    setState(() {
                      selectedIndex = value;
                    });
                  },
                  children: const <Widget>[
                    InfoPageHint(
                      assetPath: "assets/images/info1.png",
                      text: "Добро пожаловать в MediMom, вашего надежного партнера по безопасному и здоровому ведению беременности.",
                    ),
                    InfoPageHint(
                      assetPath: "assets/images/info2.png",
                      text: "Приложение предоставит инструменты отслеживания, которые помогут пользователям отслеживать ход своей беременности и послеродового периода, включая записи на приемы врачей и выбора родильных домов.",
                    ),
                  ],
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IsSelected(
                    isSelected: selectedIndex == 0,
                  ),
                  const SizedBox(width: 6),
                  IsSelected(
                    isSelected: selectedIndex == 1,
                  )
                  
                ],
              ),

              const SizedBox(height: 20),

              Padding(
                padding: EdgeInsets.symmetric(horizontal:  ConstValue.leftMarginS,),
                child: Column(
                  children: [
                    PrimaryButton(
                      text: 
                        (selectedIndex == 0) 
                          ? "Далее"
                          : "Войти в аккаунт",
                      onPressed: () {
                        _nextInfo();
                      },
                    ),
                    if (selectedIndex == 0)
                      Container(
                        margin: const EdgeInsets.only(top: 7),
                        child: ButtonText(
                          text: "Пропустить",
                          onPressed: _skipInfo
                        ),
                      )
                    else const Padding(
                      padding: EdgeInsets.only(top: 7),
                      child: ButtonText(text: "",),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}

class IsSelected extends StatelessWidget {
  final bool isSelected;
  const IsSelected({super.key,required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isSelected ? 9 : 8,
      width: isSelected ? 9 : 8,
      decoration: BoxDecoration(
        color: isSelected ? Colors.pink : Colors.pink.withOpacity(0.4),
        borderRadius: BorderRadius.circular(50),
      ),
    );
  }
}

class InfoPageHint extends StatelessWidget {
  final String assetPath;
  final String text;
  const InfoPageHint({
    super.key,
    required this.assetPath,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 60),
          width: 233,
          height: 257,
          child: Image.asset(
            assetPath,
          ),
        ),
        Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black,
            fontFamily: 'Rubik',
            fontWeight: FontWeight.w200,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 80)
      ],
    );
  }
}