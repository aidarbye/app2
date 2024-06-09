import 'package:flutter/material.dart';
import 'package:medimom/app/domain/api/doctor.dart';
import 'package:medimom/app/domain/dto/doctor/response/document_response.dart';
import 'package:medimom/app/presentation/doctor/DoctorPage.dart';
import 'package:medimom/app/presentation/doctors/DoctorWidget.dart';
import 'package:medimom/app/presentation/pack/ConstValue.dart';
import 'package:medimom/app/presentation/pack/DescriptionText.dart';
import 'package:medimom/app/presentation/pack/HeaderText.dart';

class DocumentPage extends StatefulWidget {

  final bool isAnalyze;
  const DocumentPage({super.key, required this.isAnalyze});

  @override
  State<StatefulWidget> createState() {
    return _DocumentPage();
  }
}

class _DocumentPage extends State<DocumentPage> {

  final _doctorAPI = DoctorAPI();
  final List<DocumentResponse> _documents = [];

  void _onLoaded(List<DocumentResponse> documents) {
    setState(() {
      _documents.addAll(documents);
    });
  }

  void _loadDocuments() {
    if (widget.isAnalyze) {
      _doctorAPI.findAllAnalyze().then((value) => _onLoaded(value));
    } else {
      _doctorAPI.findAllReceipts().then((value) => _onLoaded(value));
    }
  }

  @override
  void initState() {
    _loadDocuments();
    super.initState();
  }

  void _changePage(Widget widget) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          color: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                padding: EdgeInsets.only(left: ConstValue.leftMarginS, right: ConstValue.rightMarginS, top: ConstValue.topMargin),
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                      child: Stack(
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
                          Center(
                            child: HeaderText(
                              text: widget.isAnalyze ? "Анализы" : "Рецепты"
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 400,
                      child: DescriptionText(
                        text: "Список пуст",
                        alignment: Alignment.center,
                      ),
                    ),
                    Container(height: 20)
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