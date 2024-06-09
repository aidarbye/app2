import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medimom/app/domain/api/clinic.dart';
import 'package:medimom/app/domain/dto/clinic/response/ClinicUserResponse.dart';
import 'package:medimom/app/presentation/clinic/clinic_page.dart';
import 'package:medimom/app/presentation/hospitals/HospitalWidget.dart';
import 'package:medimom/app/presentation/pack/ConstValue.dart';
import 'package:medimom/app/presentation/pack/HeaderText.dart';
import 'package:medimom/app/presentation/pack/MessageHint.dart';
import 'package:medimom/app/presentation/pack/PrimaryButton.dart';
import 'package:medimom/app/presentation/pack/SearchTextField.dart';

class HospitalsPage extends StatefulWidget {

  const HospitalsPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HospitalsPage();
  }
}

class _HospitalsPage extends State<HospitalsPage> {

  final _searchController = TextEditingController();
  final _clinicAPI = ClinicAPI();
  bool _loading = true;

  final List<ClinicUserResponse> _clinics = [];
  final List<ClinicUserResponse> _clinicShowList = [];

  void _showClinicsList() {
    setState(() {
      _loading = true;
    });
    _clinicShowList.clear();
    String search = _searchController.text.toLowerCase();
    for (var clinic in _clinics) {
      if (clinic.clinic.name.toLowerCase().contains(search)) {
        _clinicShowList.add(clinic);
      }
    }
    setState(() {
      _loading = false;
    });
  }

  void _loadClinics() {
    _clinics.clear();
    _clinicAPI.findAll().then((value) {
      if (filterValue == "Все роддомы") {
        _clinics.addAll(value); 
      } else if (filterValue == "Государственные роддомы") {
        for (var element in value) { 
            if (element.clinic.type == "Государственный") {
              _clinics.add(element);
            }
          }
      } else if (filterValue == "Частные роддомы") {
        for (var element in value) { 
            if (element.clinic.type == "Частный") {
              _clinics.add(element);
            }
          }
      }
      _clinics.removeWhere((element) => element.clinic.rating < min);
      _clinics.removeWhere((element) => element.clinic.rating > max);

      _showClinicsList();
    });
  }

  @override
  void initState() {
    _loadClinics();
    super.initState();
  }

  String filterValue = "Все роддомы";
  num min = 0;
  num max = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        const Center(
                          child: HeaderText(
                              text: "Клиники"
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 24),
                    child: Row(
                      children: [
                        Expanded(
                          child: SearchTextField(
                            hint: "Поиск...",
                            controller: _searchController,
                            onSubmitted: () {
                              _showClinicsList();
                            },
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context, 
                              useSafeArea: true,
                              builder:(context) {
                                return FilterSheet(
                                  value: filterValue,
                                  start: min,
                                  end: max,
                                );
                              },
                            ).then(
                              (v) { 
                                if (v != null) {
                                  setState(() {
                                    filterValue = v['value']; 
                                    min = v['min'];
                                    max = v['max'];
                                  });
                                  _loadClinics();
                                }
                              }
                            );
                          },
                          child:Container(
                            margin: const EdgeInsets.only(left: 12),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xffF97E86)
                              ),
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: const Icon(
                              Icons.filter_alt,
                              color: Color(0xffF97E86)
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  if (_loading == false)
                  _generateHospitalsList(),
                  Container(height: 20)
                ],
              ),
            )
          ],
        ),
      ),
      
    );
  }

  Widget _generateHospitalsList() {
    List<Widget> children = [];
    for (int i = 0; i < _clinicShowList.length; i++) {
      children.add(
          HospitalWidget(
              onClick: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ClinicPage(clinicData: _clinicShowList[i])),
                );
              },
              clinicData: _clinicShowList[i]
          )
      );
    }
    return Column(children: children,);
  }

}

class FilterSheet extends StatefulWidget {
  final String value;
  final num start;
  final num end;
  const FilterSheet({
    super.key,
    required this.value,
    required this.start,
    required this.end,
  });
  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  late String value = widget.value;
  late int start = start;
  late int end = end;

  RangeValues _currentRangeValues = const RangeValues(0, 5);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Фильтры",
                  style: TextStyle(
                    fontFamily: "Rubik",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 1.5
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "Типы",
              style: TextStyle(
                fontFamily: "Rubik",
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 1.2
              ),
            ),

            RowRadio(
              title: "Государственные роддомы",
              isSelected: value.contains("Государственные"),
              callback: () {
                if (value.contains("Государственные роддомы")) {
                  setState(() {
                    value = "Все роддомы";    
                  });
                } else {
                  setState(() {
                    value = "Государственные роддомы";  
                  });
                }
              },
            ),
            RowRadio(
              title: "Частные роддомы",
              isSelected: value.contains("Частные"),
              callback: () {
                if (value.contains("Частные")) {
                  setState(() {
                    value = "Все роддомы";  
                  });
                } else {
                  setState(() {
                    value = "Частные роддомы";  
                  });
                }
              },
            ),
            RowRadio(
              title: "Все роддомы",
              isSelected: value.contains("Все"),
              callback: () {
                if (value.contains("Все")) {
                  setState(() {
                    value = "Все роддомы";  
                  });
                } else {
                  setState(() {
                    value = "Все роддомы";  
                  });
                }
              },
            ),
            const SizedBox(height: 20),
            const Text(
              "Типы",
              style: TextStyle(
                fontFamily: "Rubik",
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 1.2
              ),
            ),
            RangeSlider(
              activeColor: const Color(0xffF97E86),
              inactiveColor: Colors.grey,
              values: _currentRangeValues,
              max: 5,
              min: 0,
              divisions: 5,
              labels: RangeLabels(
                _currentRangeValues.start.round().toString(),
                _currentRangeValues.end.round().toString(),
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  _currentRangeValues = values;
                });
              },
            ),
            const SizedBox(height: 20),
            PrimaryButton(
              text: "Применить",
              onPressed: () async {
                try {
                  Navigator.of(context).pop(
                    {
                      "value": value,
                      "min": _currentRangeValues.start.ceil(), 
                      "max": _currentRangeValues.end.ceil(), 
                    }
                  );
                } catch (e) {
                  MessageHint.showMessage("Error ${e.toString()}");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class RowRadio extends StatelessWidget {
  final String title;
  final bool isSelected;
  final Function callback;
  const RowRadio({
    super.key,
    required this.title,
    required this.isSelected,
    required this.callback,
  });
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          callback.call();
        },
        child: Ink(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black
                ),
              ),
              Container(
                height: 20,
                width:  20,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 2,
                    color: const Color(0xffF97E86)
                  )
                ),
                child: Center(
                  child: Container(
                    height: 10,
                    width:  10,
                    decoration: BoxDecoration(
                      color: 
                        isSelected ? const Color(0xffF97E86) : Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    )
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}