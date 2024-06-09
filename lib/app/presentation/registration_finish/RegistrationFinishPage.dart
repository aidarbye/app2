import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:medimom/app/domain/api/user.dart';
import 'package:medimom/app/domain/dto/user/request/ChangeProfileRequest.dart';
import 'package:medimom/app/presentation/main/MainPage.dart';
import 'package:medimom/app/presentation/pack/ConstValue.dart';
import 'package:medimom/app/presentation/pack/DescriptionText.dart';
import 'package:medimom/app/presentation/pack/HeaderText.dart';
import 'package:medimom/app/presentation/pack/PrimaryButton.dart';
import 'package:medimom/app/presentation/pack/PrimaryTextField.dart';

class RegistrationFinishPage extends StatefulWidget {

  const RegistrationFinishPage({super.key});

  @override
  State<StatefulWidget> createState() => _RegistrationFinishPage();

}

class _RegistrationFinishPage extends State<RegistrationFinishPage> {

  final _nameController = TextEditingController();
  final _uuidController = TextEditingController();
  final _userAPI = UserAPI();

  final _uuidFormatter = MaskTextInputFormatter(
      mask: '############',
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.lazy
  );

  void _changePage(Widget widget) {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) {
      return widget;
    }), (route) => false);
  }

  void _onLoaded() {
    _changePage(MainPage());
  }

  void _finishRegistration() {
    if (_nameController.text.isNotEmpty && _uuidController.text.isNotEmpty) {
      _userAPI.changeProfile(
        ChangeProfileRequest(
          name: _nameController.text,
          iin: _uuidController.text
        )
      ).then((value) => _onLoaded());
    }
  }

  void _onBackPressed() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Center(
              child: Container(
                  padding: EdgeInsets.only(top: ConstValue.topMargin, left: ConstValue.rightMarginS, right: ConstValue.rightMarginS, bottom: ConstValue.bottomMargin),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: _onBackPressed,
                            borderRadius: BorderRadius.circular(10),
                            child: const SizedBox(
                              width: 30,
                              height: 30,
                              child: Icon(
                                Icons.arrow_back_ios_rounded,
                                color: Colors.black,
                              ),
                            ),
                          )
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 60),
                        child: const HeaderText(text: "Личные данные", size: 26),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: const DescriptionText(text: "Заполните поля ниже чтобы\nзавершить регистрацию"),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20, bottom: 20),
                        child: PrimaryTextField(
                          hint: "ФИО",
                          controller: _nameController,
                          action: TextInputAction.next,
                        ),
                      ),
                      PrimaryTextField(
                        hint: "ИИН",
                        formatter: _uuidFormatter,
                        controller: _uuidController,
                        keyboardType: TextInputType.number,
                        action: TextInputAction.done,
                      ),
                      Expanded(child: Container()),
                      const DescriptionText(
                          textAlign: TextAlign.start,
                          alignment: Alignment.centerLeft,
                          text: "*Завершая регистрацию, я даю согласие на обработку моих персональных данных"
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: PrimaryButton(
                          text: "Далее",
                          onPressed: _finishRegistration,
                        ),
                      ),
                    ],
                  )
              ),
            )
        )
    );
  }
}