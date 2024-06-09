// ignore_for_file: file_names

class ProfileResponse {

  num? id;
  String? name;
  String? iin;
  String? token;
  String? phone;
  String? password;

  ProfileResponse({
    required this.id,
    required this.name,
    required this.iin,
    required this.token,
    required this.phone,
    required this.password
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
        id: json["id"],
        name: json["name"],
        iin: json["iin"],
        token: json["token"],
        phone: json["phone"],
        password: json["password"]
    );
  }
}