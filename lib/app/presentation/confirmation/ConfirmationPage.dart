import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:medimom/app/domain/api/confirmation.dart';
import 'package:medimom/app/domain/dto/user/request/ConfirmRequest.dart';
import 'package:medimom/app/domain/dto/user/response/TokenRespons.dart';
import 'package:medimom/app/presentation/pack/CodeWidget.dart';
import 'package:medimom/app/presentation/pack/ConstValue.dart';
import 'package:medimom/app/presentation/pack/DescriptionText.dart';
import 'package:medimom/app/presentation/pack/HeaderText.dart';
import 'package:medimom/app/presentation/pack/MessageHint.dart';
import 'package:medimom/app/presentation/pack/PrimaryButton.dart';
import 'package:medimom/app/presentation/registration_finish/RegistrationFinishPage.dart';

class ConfirmationPage extends StatefulWidget {

  final String phone;
  const ConfirmationPage({super.key, required this.phone});

  @override
  State<StatefulWidget> createState() => _ConfirmationPage();

}

class _ConfirmationPage extends State<ConfirmationPage> {

  final _confirmationAPI = ConfirmationAPI();
  final _codeController = TextEditingController();

  final bool _error = false;

  void _changePage(Widget widget) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
  }

  void _onLoaded(TokenResponse token) {
    _changePage(RegistrationFinishPage());
  }

  void _onError() {
    MessageHint.showMessage("Wrong code");
  }

  void _finishRegistration() {
    if (_codeController.text.length == 4) {
      _confirmationAPI.confirmRegister(
          ConfirmRequest(
              phone: widget.phone,
              code: _codeController.text
          )
      ).then((value) => _onLoaded(value)).onError((error, stackTrace) => _onError());
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
                        child: const HeaderText(text: "Подтверждение", size: 26),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: const DescriptionText(text: "На указанный номер\nотправлен 4 значный код"),
                      ),
                      Container(
                        width: 260,
                        margin: const EdgeInsets.only(top: 34, bottom: 10),
                        child: CodeWidget(controller: _codeController),
                      ),
                      if (_error) const DescriptionText(
                        text: "Неверный код, попробуйте еще",
                        color: Colors.red,
                      ),
                      Expanded(child: Container()),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: PrimaryButton(
                          text: "Подтвердить",
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