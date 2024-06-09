// ignore_for_file: file_names

class ChangeProfileRequest {

  String name;
  String iin;

  ChangeProfileRequest({
    required this.name,
    required this.iin
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'iin': iin
    };
  }
}