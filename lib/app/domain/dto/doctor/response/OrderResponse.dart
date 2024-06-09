import 'package:medimom/app/domain/dto/doctor/response/DoctorResponse.dart';

class OrderResponse {
  int id;
  int dateTime;
  DoctorResponse doctorData;

  OrderResponse({
    required this.id,
    required this.dateTime,
    required this.doctorData
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
        doctorData: DoctorResponse.fromJson(json['userDoctorResponse']),
        dateTime: json['dateTime'],
        id: json['id']
    );
  }
}