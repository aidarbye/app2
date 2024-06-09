class CreateOrderRequest {

  int dateTime;
  int doctorId;

  CreateOrderRequest({
    required this.dateTime,
    required this.doctorId
  });

  Map<String, dynamic> toJson() {
    return {
      'dateTime': dateTime,
      'doctorId': doctorId
    };
  }
}