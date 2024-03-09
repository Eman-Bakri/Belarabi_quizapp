// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Question {
  final String qst;
  final Map<String, dynamic> options;
  final String answer;

  Question({required this.qst, required this.options, required this.answer});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'question': qst,
      'options': options,
      'answer': answer,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    // print("question json -------");
    return Question(
      qst: map['question'] as String,
      options: Map<String, dynamic>.from(
        (map['options'] as Map<String, dynamic>),
      ),
      answer: map['answer'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Question(qst: $qst, options: $options, answer: $answer)';
}
