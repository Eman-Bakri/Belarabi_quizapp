// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'options_model.dart';

class Question {
  final String qst;
  final List<Options> options;
  final String answer;
  final String? imageUrl;

  Question({
    required this.qst,
    required this.options,
    required this.answer,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'qst': qst,
      'options': options.map((x) => x.toMap()).toList(),
      'answer': answer,
      'imageUrl': imageUrl,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    final jsonMap = map['options'] as Map<String, dynamic>;

    final List<Options> listQuestion = [];
    jsonMap.forEach((key, value) {
      listQuestion.add(Options(id: key, title: value));
    });

    final question = Question(
      qst: map['question'] as String,
      options: listQuestion,
      answer: map['answer'] as String,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
    );
    return question;
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Question(qst: $qst, options: $options, answer: $answer)';
}
