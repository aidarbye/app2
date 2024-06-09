import 'dart:async';

import 'package:flutter/material.dart';
import 'package:medimom/app/domain/api/base.dart';
import 'package:medimom/app/domain/api/user.dart';
import 'package:medimom/app/domain/provider/user_provider.dart';
import 'package:medimom/app/presentation/info/InfoPage.dart';
import 'package:medimom/app/presentation/main/MainPage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  @override
  State<StatefulWidget> createState() {
    return _SplashPage();
  }
}

class _SplashPage extends State<SplashPage> {

  void _startLogin() {
    Navigator.pushReplacement(context, 
      MaterialPageRoute(builder: (BuildContext context) {
        return const InfoPage();
      }),
    );
  }

  void _startMain() {
    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(
        builder: (BuildContext context) {
          return const MainPage();
        }
      )
    );
  }

  void _checkProfile() {
    BaseAPI.reloadHeader().then((value) => {
      UserAPI().checkProfile().then((value) => _startMain()).onError((error, stackTrace) => _startLogin())
    });
  }

  void _checkToken() {
    UserProvider().getAuthToken().then(
      (_) => _checkProfile()
    ).onError((error, stackTrace) {
      _startLogin();
    });
  }

  void _startTimer() {
    Timer.periodic(const Duration(seconds: 2), (timer) {
      timer.cancel();
      _checkToken();
    });
  }

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.fromLTRB(20, 20, 20, 80),
                child: Image.asset(
                  "assets/images/logo.png",
                  width: 220,
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}