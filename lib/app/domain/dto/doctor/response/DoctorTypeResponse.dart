class DoctorTypeResponse {

  int id;
  String name;
  String imageUrl;

  DoctorTypeResponse({
    required this.id,
    required this.name,
    required this.imageUrl,
  });


  factory DoctorTypeResponse.fromJson(Map<String, dynamic> json) {
    return DoctorTypeResponse(
        id: json['id'],
        name: json['name'],
        imageUrl: json['imageUrl'],
    );
  }
}