import 'package:flutter/material.dart';
import 'package:medimom/app/data/DoctorViewData.dart';
import 'package:medimom/app/data/HostipalViewData.dart';
import 'package:medimom/app/domain/api/clinic.dart';
import 'package:medimom/app/domain/api/doctor.dart';
import 'package:medimom/app/domain/api/favorite.dart';
import 'package:medimom/app/domain/dto/clinic/response/ClinicResponse.dart';
import 'package:medimom/app/domain/dto/clinic/response/ClinicUserResponse.dart';
import 'package:medimom/app/domain/dto/doctor/response/DoctorResponse.dart';
import 'package:medimom/app/presentation/doctors/DoctorWidget.dart';
import 'package:medimom/app/presentation/hospitals/HospitalWidget.dart';
import 'package:medimom/app/presentation/pack/ConstValue.dart';
import 'package:medimom/app/presentation/pack/HeaderText.dart';
import 'package:medimom/app/presentation/pack/SearchTextField.dart';

class FavoritePage extends StatefulWidget {

  const FavoritePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _FavoritePage();
  }
}

class _FavoritePage extends State<FavoritePage> {

  final _searchController = TextEditingController();
  final _typeValues = ["Доктора", "Клиники", "Статьи"];
  var _selectedTypeIndex = 0;
  bool _loading = true;

  final FavoriteAPI _favoriteAPI = FavoriteAPI();
  final List<DoctorResponse> _mainDoctorList = [];
  final List<ClinicUserResponse> _mainClinicList = [];
  final List<DoctorResponse> _doctors = [];
  final List<ClinicUserResponse> _hospitals = [];

  void _loadDoctors() {
    _favoriteAPI.doctorList().then((value) => {
      _mainDoctorList.addAll(value),
      _loadClinics()
    });
  }

  void _loadClinics() {
    _favoriteAPI.clinicsList().then((value) => {
      _mainClinicList.addAll(value),
      _searchLoad()
    });
  }

  void _searchLoad() {
    setState(() {
      _loading = true;
    });
    _doctors.clear();
    _hospitals.clear();
    String search = _searchController.text.toLowerCase();
    for (var doctor in _mainDoctorList) {
      if (doctor.doctor.name.toLowerCase().contains(search)) {
        _doctors.add(doctor);
      }
    }
    for (var clinic in _mainClinicList) {
      if (clinic.clinic.name.toLowerCase().contains(search)) {
        _hospitals.add(clinic);
      }
    }
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    _loadDoctors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            padding: EdgeInsets.only(left: ConstValue.leftMarginS, right: ConstValue.rightMarginS, top: ConstValue.topMargin),
            width: double.infinity,
            child: Column(
              children: [
                const HeaderText(
                  text: "Избранное"
                ),
                Container(
                  margin: const EdgeInsets.only(top: 24),
                  child: SearchTextField(
                    hint: "Поиск...",
                    controller: _searchController,
                    onSubmitted: () {
                      _searchLoad();
                    },
                  ),
                ),
                Row(
                  children: [
                    Expanded(child: Container()),
                    PopupMenuButton(
                      surfaceTintColor: Colors.white,
                      color: Colors.white,
                      padding: EdgeInsets.zero,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                      clipBehavior: Clip.hardEdge,
                      itemBuilder: _generatePopupActions,
                      onSelected: (value) {
                        setState(() {
                          _selectedTypeIndex = int.parse(value.toString());
                        });
                      },
                      icon: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              _typeValues[_selectedTypeIndex],
                              style: const TextStyle(
                                  color: Color.fromRGBO(249, 126, 134, 1),
                                  fontFamily: 'Rubik',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.arrow_drop_down,
                            color: Color.fromRGBO(249, 126, 134, 1),
                            size: 18,
                          )
                        ],
                      ),
                    )
                  ],
                ),
                if (!_loading)
                _selectedTypeIndex == 0 ? _generateDoctorsList() : _generateHospitalsList(),
                Container(height: 20)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _generateDoctorsList() {
    List<Widget> children = [];
    for (int i = 0; i < _doctors.length; i++) {
      children.add(
        DoctorWidget(
          onClick: () {

          },
          doctorData: _doctors[i]
        )
      );
    }
    return Column(children: children,);
  }

  Widget _generateHospitalsList() {
    List<Widget> children = [];
    for (int i = 0; i < _hospitals.length; i++) {
      children.add(
        HospitalWidget(
          onClick: () {

          },
          clinicData: _hospitals[i]
        )
      );
    }
    return Column(children: children,);
  }

  List<PopupMenuEntry<Object>> _generatePopupActions(BuildContext context) {
    List<PopupMenuEntry<Object>> list = [];
    for (int i = 0; i < 3; i++) {
      list.add(PopupMenuItem(
        height: 40,
        value: i,
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 60),
              child: Text(
                _typeValues[i],
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.normal
                ),
              ),
            ),
            Expanded(child: Container()),
            if (i == _selectedTypeIndex) const Icon(
              Icons.check,
              color: Color.fromRGBO(249, 126, 134, 1),
              size: 14,
            )
          ],
        ),
      ));
    }
    return list;
  }

}