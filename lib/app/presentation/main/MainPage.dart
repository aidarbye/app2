import 'package:flutter/material.dart';
import 'package:medimom/app/presentation/checklist/CheckListPage.dart';
import 'package:medimom/app/presentation/custom_navigation/MediMomMotionTabBar.dart';
import 'package:medimom/app/presentation/custom_navigation/MediMomMotionTabController.dart';
import 'package:medimom/app/presentation/favorite/FavoritePage.dart';
import 'package:medimom/app/presentation/home/HomePage.dart';
import 'package:medimom/app/presentation/med_card/MedCardPage.dart';
import 'package:medimom/app/presentation/profile/ProfilePage.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<StatefulWidget> createState() {
    return _MainPage();
  }
}

class _MainPage extends State<MainPage> with TickerProviderStateMixin{

  late MediMomMotionTabBarController _motionTabBarController;

  @override
  void initState() {
    super.initState();
    _motionTabBarController = MediMomMotionTabBarController(
      initialIndex: 0,
      length: 5,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _motionTabBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _motionTabBarController,
        children: const <Widget>[
          HomePage(),
          MedCardPage(),
          FavoritePage(),
          CheckListPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: MediMomMotionTabBar(
        controller: _motionTabBarController,
        initialSelectedTab: "Главная",
        labels: const ["Главная", "Медкарта", "Избранное", "Помощник", "другое"],
        iconPath: const ["assets/images/home.png", "assets/images/document.png", "assets/images/heart.png", "assets/images/checklist.png", "assets/images/more.png"],
        onTabItemSelected: (int value) {
          if (_motionTabBarController.index == value) {
            return;
          }
          setState(() {
            _motionTabBarController.index = value;
          });
        },
      ),     
    );
  }

}