import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:medimom/app/domain/api/user.dart';
import 'package:medimom/app/domain/dto/user/request/RegisterRequest.dart';
import 'package:medimom/app/presentation/confirmation/ConfirmationPage.dart';
import 'package:medimom/app/presentation/pack/ConstValue.dart';
import 'package:medimom/app/presentation/pack/DescriptionText.dart';
import 'package:medimom/app/presentation/pack/HeaderText.dart';
import 'package:medimom/app/presentation/pack/MessageHint.dart';
import 'package:medimom/app/presentation/pack/PrimaryButton.dart';
import 'package:medimom/app/presentation/pack/PrimaryTextField.dart';

class RegistrationPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _RegistrationPage();

}

class _RegistrationPage extends State<RegistrationPage> {

  final _phoneFormatter = MaskTextInputFormatter(
      mask: '+7 (###) ###-##-##',
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.lazy
  );

  final _phoneController = TextEditingController();

  final _passwordController = TextEditingController();

  final _userAPI = UserAPI();

  void _changePage(Widget widget) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
  }

  void _getCode() {
    if (_phoneController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
      _userAPI.register(
          RegisterRequest(
              phone: _phoneController.text,
              password: _passwordController.text
          )
      ).then((value) => _success()).onError((error, stackTrace) => _error(error));
    }
  }

  void _success() {
    _changePage(ConfirmationPage(phone: _phoneController.text));
  }

  void _error(error) {
    print(error);
    MessageHint.showMessage("Номер телефона уже зарегистрирован!");
    setState(() {
      _phoneController.clear();
      _passwordController.clear();
    });
  }

  void _register() {

  }

  void _onBackPressed() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = (MediaQuery.of(context).size.width - 32 - ConstValue.rightMarginS * 2) / 3;
    return MaterialApp(
        home: Scaffold(
            body: Center(
              child: Container(
                  padding: EdgeInsets.only(top: ConstValue.topMargin, left: ConstValue.rightMarginS, right: ConstValue.rightMarginS, bottom: ConstValue.bottomMargin),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(child: Container()),
                          InkWell(
                            onTap: _onBackPressed,
                            borderRadius: BorderRadius.circular(10),
                            child: const SizedBox(
                              width: 30,
                              height: 30,
                              child: Icon(
                                Icons.close_rounded,
                                color: Colors.black,
                              ),
                            ),
                          )
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 60),
                        child: const HeaderText(text: "Регистрация", size: 26),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: const DescriptionText(text: "Введите номер телефона и\nпридумайте пароль"),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20, bottom: 20),
                        child: PrimaryTextField(
                          hint: "Номер телефона",
                          formatter: _phoneFormatter,
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
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
                          text: "Получить код",
                          onPressed: _getCode,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 40, bottom: 18),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(right: 11),
                                height: 1,
                                color: const Color.fromRGBO(0, 0, 0, 0.05),
                              ),
                            ),
                            const DescriptionText(
                                textAlign: TextAlign.center,
                                text: "Другие способы"
                            ),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(left: 11),
                                height: 1,
                                color: const Color.fromRGBO(0, 0, 0, 0.05),
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                          children: [
                            InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: () {
                                _register();
                              },
                              child: Container(
                                height: 55,
                                width: screenWidth,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: const Color.fromRGBO(0, 0, 0, 0.05),
                                        width: 1
                                    )
                                ),
                                child: Image.asset(
                                  "assets/images/google.png",
                                  height: 26,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 16),
                              child: InkWell(
                                onTap: () {
                                  _register();
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 55,
                                  width: screenWidth,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: const Color.fromRGBO(0, 0, 0, 0.05),
                                          width: 1
                                      )
                                  ),
                                  child: Image.asset(
                                    "assets/images/apple.png",
                                    height: 26,
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: () {
                                _register();
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 55,
                                width: screenWidth,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: const Color.fromRGBO(0, 0, 0, 0.05),
                                        width: 1
                                    )
                                ),
                                child: Image.asset(
                                  "assets/images/facebook.png",
                                  height: 24,
                                ),
                              ),
                            )
                          ]
                      )
                    ],
                  )
              ),
            )
        )
    );
  }
}