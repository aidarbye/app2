import 'package:medimom/app/data/DoctorViewData.dart';
import 'package:medimom/app/domain/dto/clinic/response/ClinicResponse.dart';

class DoctorResponse {
  DoctorViewData doctor;
  bool isFavorite;

  DoctorResponse({
    required this.doctor,
    required this.isFavorite,
  });

  factory DoctorResponse.fromJson(Map<String, dynamic> json) {
    return DoctorResponse(
        doctor: DoctorViewData.fromJson(json['doctor']),
        isFavorite: json['favorite'] ?? false
    );
  }
}