import 'package:flutter/material.dart';
import 'package:medimom/app/domain/api/user.dart';
import 'package:medimom/app/domain/dto/user/response/ProfileResponse.dart';
import 'package:medimom/app/presentation/pack/ConstValue.dart';
import 'package:medimom/app/presentation/pack/DescriptionText.dart';
import 'package:medimom/app/presentation/pack/HeaderText.dart';

class PersonalDataPage extends StatefulWidget {

  const PersonalDataPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PersonalDataPage();
  }
}

class _PersonalDataPage extends State<PersonalDataPage> {
  late final UserAPI userAPI = UserAPI();
  late final Future<ProfileResponse> future = userAPI.checkProfile();
  @override
  void initState() {
    super.initState();
  }

  Widget buildRow(String title, String text) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 3,
          child: Text(
            text,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: ConstValue.leftMarginS, right: ConstValue.rightMarginS, top: ConstValue.topMargin),
                width: double.infinity,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      height: 40,
                      child: Stack(
                        children: [
                          const Center(
                            child: HeaderText(
                                text: "Личные данные"
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
                            ],
                          )
                        ],
                      ),
                    ),
                    FutureBuilder<ProfileResponse>(
                      future: future, 
                      builder:(context, snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildRow(
                                "Имя", 
                                snapshot.data?.name ?? "Имя не указано",
                              ),
                              const Divider(),
                              buildRow(
                                "ИИН", 
                                snapshot.data?.iin ?? "iin не указан",
                              ),
                              const Divider(),
                              buildRow(
                                "Номер", 
                                snapshot.data?.phone ?? "Телефон не указан",
                              ),
                              const Divider(),
                            ]
                          );
                        } else {
                          return const DescriptionText(
                            text: "Чтобы поставить на учет обратитесь к доктору",
                            textAlign: TextAlign.start,
                          );
                        }
                      },
                    ),
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