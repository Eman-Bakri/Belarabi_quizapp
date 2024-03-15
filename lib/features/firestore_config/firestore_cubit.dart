// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app_with_eman/features/firestore_config/firestore_repository.dart';
import 'package:quiz_app_with_eman/features/firestore_config/model/questions_model.dart';

abstract class FirestoreConfigState {}

class FirestoreConfigInitialState extends FirestoreConfigState {}

class FirestoreConfigFetchInProgress extends FirestoreConfigState {}

class FirestoreConfigFetchSuccess extends FirestoreConfigState {
  final List<Question> listQuestion;

  FirestoreConfigFetchSuccess({required this.listQuestion});
}

class FirestoreConfigFetchFailer extends FirestoreConfigState {
  final String errorMessage;

  FirestoreConfigFetchFailer({required this.errorMessage});
}

class FirestoreCubit extends Cubit<FirestoreConfigState> {
  final FirestoreRepository _firestoreRepository;

  FirestoreCubit(
    this._firestoreRepository,
  ) : super(FirestoreConfigInitialState());

  Future<void> fetchDataFromFirestore({
    required bool isArabic,
    required String category,
    required String subCategory,
    required String level,
  }) async {
    emit(FirestoreConfigFetchInProgress());
    final questionsList = await _firestoreRepository.getQuestions(
      isArabic: isArabic,
      category: category,
      subCategory: subCategory,
      level: level,
    );

    if (questionsList.isEmpty) {
      emit(FirestoreConfigFetchFailer(errorMessage: "000"));
    } else {
      emit(FirestoreConfigFetchSuccess(listQuestion: questionsList));
    }
  }

  List<Question> questions() {
    if (state is FirestoreConfigFetchSuccess) {
      return (state as FirestoreConfigFetchSuccess).listQuestion;
    }
    return [];
  }
}
