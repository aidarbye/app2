class DocumentResponse {
  String url;
  int dateTime;

  DocumentResponse({
    required this.url,
    required this.dateTime
  });

  factory DocumentResponse.fromJson(Map<String, dynamic> json) {
    return DocumentResponse(
        dateTime: json['dateTime'],
        url: json['url']
    );
  }
}