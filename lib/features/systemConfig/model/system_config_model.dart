// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SystemConfigModel {
  String? quizTimer;

  SystemConfigModel({this.quizTimer});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'quizTimer': quizTimer,
    };
  }

  factory SystemConfigModel.fromMap(Map<String, dynamic> map) {
    return SystemConfigModel(
      quizTimer: map['quizTimer'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SystemConfigModel.fromJson(String source) =>
      SystemConfigModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
