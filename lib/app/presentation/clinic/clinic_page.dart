import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medimom/app/domain/api/doctor.dart';
import 'package:medimom/app/domain/api/favorite.dart';
import 'package:medimom/app/domain/dto/clinic/response/ClinicUserResponse.dart';
import 'package:medimom/app/domain/dto/doctor/response/DoctorResponse.dart';
import 'package:medimom/app/presentation/doctor/DoctorPage.dart';
import 'package:medimom/app/presentation/doctors/DoctorWidget.dart';
import 'package:medimom/app/presentation/pack/ConstValue.dart';
import 'package:medimom/app/presentation/pack/HeaderText.dart';
import 'package:url_launcher/url_launcher.dart';

class ClinicPage extends StatefulWidget {

  final ClinicUserResponse clinicData;

  const ClinicPage({super.key, required this.clinicData});

  @override
  State<StatefulWidget> createState() {
    return _ClinicPage();
  }
}

class _ClinicPage extends State<ClinicPage> {

  final _favoriteAPI = FavoriteAPI();
  final _doctorAPI = DoctorAPI();
  final List<DoctorResponse> _doctors = [];
  late bool _isFavorite;

  void _setDoctors(List<DoctorResponse> doctors) {
    for (var doctor in doctors) {
      if (doctor.doctor.clinic.clinic.id == widget.clinicData.clinic.id) {
        setState(() {
          _doctors.add(doctor);
        });
      }
    }
  }

  void _loadDoctors() {
    _doctorAPI.findAll().then((value) => {
      _setDoctors(value)
    });
  }

  void _favoriteClicked() {
    if (_isFavorite) {
      _favoriteAPI.removeClinic(widget.clinicData.clinic.id);
      setState(() {
        _isFavorite = false;
      });
    } else {
      _favoriteAPI.addClinic(widget.clinicData.clinic.id);
      setState(() {
        _isFavorite = true;
      });
    }
  }

  void _changePage(Widget widget) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
  }

  @override
  void initState() {
    _isFavorite = widget.clinicData.isFavorite;
    _loadDoctors();
    super.initState();
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
                padding: EdgeInsets.only(left: ConstValue.leftMarginS, right: ConstValue.rightMarginS, top: ConstValue.topMargin),
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                      child: Stack(
                        children: [
                          const Center(
                            child: HeaderText(
                                text: "Клиника"
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
                              Expanded(child: Container()),
                              Container(
                                margin: const EdgeInsets.only(top: 5),
                                width: 30,
                                height: 30,
                                child: InkWell(
                                  onTap: () {
                                    _favoriteClicked();
                                  },
                                  borderRadius: BorderRadius.circular(10),
                                  child: SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: Icon(
                                      _isFavorite ? Icons.favorite : Icons.favorite_border,
                                      color: const Color.fromRGBO(249, 126, 134, 1),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      height: 115,
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              widget.clinicData.clinic.imageUrl,
                              width: 115,
                              height: 115,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.clinicData.clinic.name,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'Rubik'
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 6),
                                  child: Text(
                                    widget.clinicData.clinic.type,
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.6),
                                        fontSize: 14,
                                        fontFamily: 'Rubik'
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_on_rounded,
                                            color: Colors.black.withOpacity(0.6),
                                            size: 12,
                                          ),
                                        GestureDetector(
                                          onTap: () async {
                                            if (await canLaunchUrl(Uri.parse(widget.clinicData.clinic.description))) {
                                              await launchUrl(Uri.parse(widget.clinicData.clinic.description));
                                            } 
                                          },
                                            child: Text(
                                              widget.clinicData.clinic.address,
                                              style: TextStyle(
                                                  color: Colors.black.withOpacity(0.6),
                                                  fontSize: 12,
                                                  fontFamily: 'Rubik',
                                                  fontWeight: FontWeight.normal
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    if (_doctors.isNotEmpty)
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const HeaderText(text: "Доктора", size: 18, textAlign: TextAlign.start, alignment: Alignment.centerLeft),
                    ),
                    Column(
                      children: List.generate(_doctors.length, (index) => DoctorWidget(
                          onClick: (doctor) {
                            _changePage(DoctorPage(doctorData: doctor));
                          },
                          doctorData: _doctors[index]
                      )),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      
    );
  }

}