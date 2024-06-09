import 'package:medimom/app/domain/dto/clinic/response/ClinicResponse.dart';
import 'package:medimom/app/domain/dto/clinic/response/ClinicUserResponse.dart';
import 'package:medimom/app/domain/dto/doctor/response/DoctorTypeResponse.dart';

class DoctorViewData {

  int id;
  DoctorTypeResponse type;
  ClinicUserResponse clinic;
  String name;
  String rating;
  String info;
  String imageUrl;

  DoctorViewData({
    required this.id,
    required this.type,
    required this.clinic,
    required this.name,
    required this.rating,
    required this.info,
    required this.imageUrl,
  });


  factory DoctorViewData.fromJson(Map<String, dynamic> json) {
    return DoctorViewData(
        id: json['id'],
        type: DoctorTypeResponse.fromJson(json['doctorType']),
        clinic: ClinicUserResponse.fromJson(json['clinic']),
        name: json['name'],
        rating: json['rating'],
        info: json['info'],
        imageUrl: json['imageUrl'],
    );
  }


}