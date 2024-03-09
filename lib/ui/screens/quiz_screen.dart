// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app_with_eman/features/firestore_config/firestore_cubit.dart';

class QuizScreen extends StatefulWidget {
  final String? language;
  final String? category;
  final String? subCategory;
  final String? level;
  const QuizScreen({
    Key? key,
    required this.language,
    required this.category,
    required this.subCategory,
    required this.level,
  }) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<FirestoreCubit>().fetchDataFromFirestore(
          language: widget.language ?? "",
          category: widget.category ?? "",
          subCategory: widget.subCategory ?? "",
          level: widget.level ?? "",
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Quiz Screen"),
      ),
    );
  }
}
