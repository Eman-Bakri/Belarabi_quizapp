// ignore_for_file: public_member_api_docs, sort_constructors_first

class SupportedLanguages {
  final String id;
  final String language;
  final String lanugageCode;
  SupportedLanguages({
    required this.id,
    required this.language,
    required this.lanugageCode,
  });

  factory SupportedLanguages.fromJson(Map<String, dynamic> map) {
    return SupportedLanguages(
      id: map['id'] as String,
      language: map['language'] as String,
      lanugageCode: map['lanugageCode'] as String,
    );
  }
}
