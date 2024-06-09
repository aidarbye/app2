class HospitalViewData {

  String imagePath;
  String name;
  String type;
  String address;
  double rating;
  String description;
  bool isFavorite;

  HospitalViewData({
    required this.imagePath,
    required this.name,
    required this.type,
    required this.address,
    required this.rating,
    this.description = "Подходы: Системные расстановки; психосоматическая кинезиология, кататимно-имагинативная терапия; аналитическая психология и терапия. Сертифицирована в 6 методах, что позволяет подобрать индивидуальный подход для каждого запроса.",
    this.isFavorite = false
  });

}