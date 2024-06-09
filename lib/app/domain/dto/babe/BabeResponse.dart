class BabeResponse {
  int? id;
  int? userId;
  dynamic weight;
  dynamic age;
  dynamic size;

  BabeResponse({
    required this.id,
    required this.weight,
    required this.userId,
    required this.age,
    required this.size,
  });

  factory BabeResponse.fromJson(Map<String, dynamic> json) {
    return BabeResponse(
        id: json['id'],
        userId: json['user']['id'],
        weight: json['weight'],
        age: json['age'],
        size: json['size'],
    );
  }
}
