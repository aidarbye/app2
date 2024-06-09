class ClinicResponse {
  int id;
  String name;
  String description;
  String imageUrl;
  double rating;
  String address;
  String type;

  ClinicResponse({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.rating,
    required this.address,
    required this.type
  });

  factory ClinicResponse.fromJson(Map<String, dynamic> json) {
    return ClinicResponse(
        id: json['id'] ?? 0,
        name: json['name'] ?? "",
        description: json['description'] ?? "",
        imageUrl: json['imageUrl'] ?? "",
        rating: json['rating'] ?? 0,
        address: json['address'] ?? "",
        type: json['type'] ?? ""
    );
  }
}