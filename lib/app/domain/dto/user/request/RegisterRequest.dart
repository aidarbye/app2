class RegisterRequest {

  String phone;
  String password;

  RegisterRequest({
    required this.phone,
    required this.password
  });

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'password': password
    };
  }
}