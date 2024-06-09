import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:medimom/app/domain/api/base.dart';
import 'package:medimom/app/domain/api/user.dart';
import 'package:medimom/app/domain/dto/user/request/LoginRequest.dart';
import 'package:medimom/app/domain/dto/user/response/TokenRespons.dart';
import 'package:medimom/app/presentation/main/MainPage.dart';
import 'package:medimom/app/presentation/pack/ButtonText.dart';
import 'package:medimom/app/presentation/pack/ConstValue.dart';
import 'package:medimom/app/presentation/pack/DescriptionText.dart';
import 'package:medimom/app/presentation/pack/HeaderText.dart';
import 'package:medimom/app/presentation/pack/MessageHint.dart';
import 'package:medimom/app/presentation/pack/PrimaryButton.dart';
import 'package:medimom/app/presentation/pack/PrimaryTextField.dart';
import 'package:medimom/app/presentation/registration/RegistrationPage.dart';

class AuthorizationPage extends StatefulWidget {
  const AuthorizationPage({super.key});
  @override
  State<StatefulWidget> createState() => _AuthorizationPage();
}

class _AuthorizationPage extends State<AuthorizationPage> {

  final _phoneFormatter = MaskTextInputFormatter(
    mask: '+7 (###) ###-##-##',
    filter: { "#": RegExp(r'[0-9]') },
    type: MaskAutoCompletionType.lazy
  );

  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _userAPI = UserAPI();

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _register() {
    Navigator.push(context,MaterialPageRoute(builder: (context) => RegistrationPage()));
  }

  void _doLogin() {
    if (_phoneController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
      
      final phone = "+${getRawPhoneNumber(_phoneController.text)}";
      final password = _passwordController.text;

      _userAPI.login(
        LoginRequest(
          phone: phone,
          password: password
        )
      ).then((value) => _success(value)).onError((error, stackTrace) => _error());
    }
  }

  void _success(TokenResponse tokenResponse) {
    BaseAPI.reloadHeader().then((value) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainPage()),
      );
    });
  }

  void _error() {
    MessageHint.showMessage("Неправильный логин или пароль");
    setState(() {
      _phoneController.clear();
      _passwordController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: ConstValue.topMargin, left: ConstValue.rightMarginS, right: ConstValue.rightMarginS, bottom: ConstValue.bottomMargin),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: const HeaderText(text: "Добро пожаловать!", size: 26),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: const DescriptionText(text: "Введите номер телефона и\nпароль войти"),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 20),
                    child: PrimaryTextField(
                      hint: "Номер телефона",
                      formatter: _phoneFormatter,
                      controller: _phoneController,
                      keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                    ),
                  ),
                  PrimaryTextField(
                    hint: "Пароль",
                    controller: _passwordController,
                    isPassword: true,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: PrimaryButton(
                      text: "Войти",
                      onPressed: _doLogin,
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    padding: const EdgeInsets.only(top: 15),
                    child: const DescriptionText(
                      text: "Нет аккаунта?",
                      color: Colors.black,
                    ),
                  ),
                  ButtonText(
                    text: "Зарегистрироваться",
                    onPressed: _register,
                  )
                ],
              )
          ),
        ),
      )       
    );
  }
}

String getRawPhoneNumber(String formattedPhoneNumber) {
  return formattedPhoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
}