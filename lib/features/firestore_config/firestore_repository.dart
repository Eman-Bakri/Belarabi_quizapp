import 'package:quiz_app_with_eman/features/firestore_config/model/firestore_remote_data_source.dart';

import 'model/questions_model.dart';

class FirestoreRepository {
  static final FirestoreRepository _firestoreRepository =
      FirestoreRepository._instance();

  late FirestoreRemoteDataSource _firestoreRemoteDataSource;

  factory FirestoreRepository() {
    _firestoreRepository._firestoreRemoteDataSource =
        FirestoreRemoteDataSource();
    return _firestoreRepository;
  }

  FirestoreRepository._instance();

  Future<List<Question>> getQuestions({
    required String language,
    required String category,
    required String subCategory,
    required String level,
  }) async {
    return _firestoreRemoteDataSource.fetchAllQuestions(
        language: language,
        category: category,
        subCategory: subCategory,
        level: level);
  }
}
