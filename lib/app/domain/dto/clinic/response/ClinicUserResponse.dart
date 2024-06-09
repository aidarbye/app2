import 'package:medimom/app/domain/dto/clinic/response/ClinicResponse.dart';

class ClinicUserResponse {
  ClinicResponse clinic;
  bool isFavorite;

  ClinicUserResponse({
    required this.clinic,
    required this.isFavorite,
  });

  factory ClinicUserResponse.fromJson(Map<String, dynamic> json) {
    return ClinicUserResponse(
      clinic: ClinicResponse.fromJson(json['clinic']),
      isFavorite: json['favorite'] ?? false
    );
  }
}