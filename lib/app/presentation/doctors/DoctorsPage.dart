import 'package:flutter/material.dart';
import 'package:medimom/app/domain/api/doctor.dart';
import 'package:medimom/app/domain/dto/doctor/response/DoctorResponse.dart';
import 'package:medimom/app/presentation/doctor/DoctorPage.dart';
import 'package:medimom/app/presentation/doctors/DoctorWidget.dart';
import 'package:medimom/app/presentation/pack/ConstValue.dart';
import 'package:medimom/app/presentation/pack/HeaderText.dart';
import 'package:medimom/app/presentation/pack/SearchTextField.dart';

class DoctorsPage extends StatefulWidget {
  const DoctorsPage({super.key});
  @override
  State<StatefulWidget> createState() {
    return _DoctorsPage();
  }
}

class _DoctorsPage extends State<DoctorsPage> {

  final _doctorAPI = DoctorAPI();
  final _searchController = TextEditingController();

  final List<DoctorResponse> _doctors = [];
  final List<DoctorResponse> _showDoctors = [];

  int? selectedFilter;

  bool _loading = true;

  void _showDoctorList() {
    setState(() {
      _loading = true;
    });
    _showDoctors.clear();
    var search = _searchController.text.toLowerCase();
    for (var doctor in _doctors) {
      if (doctor.doctor.name.toLowerCase().contains(search)) {
        _showDoctors.add(doctor);
      }
    }
    setState(() {
      _loading = false;
    });
  }

  void _loadDoctors() {
    _doctorAPI.findAll().then((value) => {
      _doctors.addAll(value),
      _showDoctorList()
    });
  }

  @override
  void initState() {
    _loadDoctors();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  
  void _changePage(Widget widget) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
  }

  void filterCallback(String title,int index) {
    setState(() {
      selectedFilter = index;  
    });

    List<DoctorResponse> som = [];
    _showDoctors.clear();

    _doctorAPI.findAll().then((value) {
      som.addAll(value);
      for (var element in som) { 
        if (element.doctor.type.name.contains(title)) {
          _showDoctors.add(element);
        }
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              padding: EdgeInsets.only(left: ConstValue.leftMarginS, top: ConstValue.topMargin),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: ConstValue.rightMargin),
                    child: SizedBox(
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
                                text: "Доктора"
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: ConstValue.rightMargin),
                    child: Container(
                      margin: const EdgeInsets.only(top: 24),
                      child: SearchTextField(
                        hint: "Поиск...",
                        controller: _searchController,
                        onSubmitted: () {
                            _showDoctorList();
                        },
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 20,bottom: 10),
                    child: SizedBox(
                      height: 100,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        children: [
                          FilterItem(
                            isSelected: (selectedFilter == 0),
                            title: "Гинеколог",
                            asset: "assets/images/tera.png",
                            callback: filterCallback,
                            selectedIndex: selectedFilter,
                            index: 0,
                          ),
                          const SizedBox(width: 30),
                          FilterItem(
                            title: "Стоматолог",
                            isSelected: (selectedFilter == 1),
                            asset: "assets/images/stom.png",
                            callback:filterCallback,
                            selectedIndex: selectedFilter,
                            index: 1,
                          ),
                          const SizedBox(width: 30),
                          FilterItem(
                            isSelected: (selectedFilter == 2),
                            title: "Кардиолог",
                            asset: "assets/images/kardio.png",
                            callback: filterCallback,
                            selectedIndex: selectedFilter,
                            index: 2,
                          ),
                        ],
                      ),
                    ),
                  ),

                    if (!_loading)
                    Padding(
                      padding: EdgeInsets.only(right: ConstValue.rightMargin),
                      child: _generateDoctorsList(_doctors),
                    ),
                  Container(height: 20)
                ],
              ),
            )
          ],
        ),
      ),
    
    );
  }

  Widget _generateDoctorsList(List<DoctorResponse> doctors) {
    List<Widget> children = [];
    for (int i = 0; i < _showDoctors.length; i++) {
      children.add(
        DoctorWidget(
          onClick: (doctor) {
            _changePage(DoctorPage(doctorData: doctor));
          },
          doctorData: _showDoctors[i]
        )
      );
    }
    return Column(children: children,);
  }

}

class FilterItem extends StatelessWidget {
  final String title;
  final int? selectedIndex;
  final bool isSelected;
  final String asset;
  final Function callback;
  final int index;
  const FilterItem({
    super.key,
    required this.title,
    required this.asset,
    this.selectedIndex,
    required this.isSelected,
    required this.callback,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        callback.call(title,index);
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.red.withOpacity(0.2) : Colors.white,
          borderRadius: BorderRadius.circular(12)
        ),
        child: Column(
          children: [
            Image.asset(asset),
            const SizedBox(height: 8),
            Text(title)
          ],
        ),
      ),
    );
  }
}