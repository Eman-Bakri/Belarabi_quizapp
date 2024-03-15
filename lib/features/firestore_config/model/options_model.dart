import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Options {
  final String? id;
  final String? title;
  Options({
    this.id,
    this.title,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
    };
  }

  factory Options.fromMap(Map<String, dynamic> map) {
    return Options(
      id: map['id'] != null ? map['id'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Options.fromJson(String source) =>
      Options.fromMap(json.decode(source) as Map<String, dynamic>);
}
