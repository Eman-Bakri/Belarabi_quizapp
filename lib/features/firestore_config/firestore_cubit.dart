// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app_with_eman/features/firestore_config/firestore_repository.dart';

abstract class FirestoreConfigState {}

class FirestoreConfigInitialState extends FirestoreConfigState {}

class FirestoreConfigFetchInProgress extends FirestoreConfigState {}

class FirestoreConfigFetchSuccess extends FirestoreConfigState {}

class FirestoreConfigFetchFailer extends FirestoreConfigState {}

class FirestoreCubit extends Cubit<FirestoreConfigState> {
  final FirestoreRepository _firestoreRepository;
  FirestoreCubit(
    this._firestoreRepository,
  ) : super(FirestoreConfigInitialState());

  Future<void> fetchDataFromFirestore({
    required String language,
    required String category,
    required String subCategory,
    required String level,
  }) async {
    await _firestoreRepository.getQuestions(
        language: language,
        category: category,
        subCategory: subCategory,
        level: level);
  }
}
