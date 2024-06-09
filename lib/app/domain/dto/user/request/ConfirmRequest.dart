class ConfirmRequest {

  String phone;
  String code;

  ConfirmRequest({
    required this.phone,
    required this.code
  });

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'code': code
    };
  }
}