import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_app_with_eman/features/firestore_config/model/questions_model.dart';

class FirestoreRemoteDataSource {
  Future<List<Question>> fetchAllQuestions({
    required bool isArabic,
    required String category,
    required String subCategory,
    required String level,
  }) async {
    final firestore = FirebaseFirestore.instance;

    try {
      print(
          "isArbic: $isArabic, categorie: $category, subCategory: $subCategory, level : $level");
      List<Question> questionsList = [];
      QuerySnapshot querySnapshotAR = await firestore
          .collection("quiz_arabic")
          .doc(category)
          .collection(subCategory)
          .doc("مستوى 1")
          .collection("Questions")
          .get();

      // print(
      // "category: $category, subCategory:$subCategory, language: $language,level: $level");
      QuerySnapshot querySnapshotEN = await firestore
          .collection("Quiz")
          .doc(category)
          .collection(subCategory)
          .doc("Level 1")
          .collection("Questions")
          .get();
      (isArabic ? querySnapshotAR : querySnapshotEN).docs.forEach(
        (element) {
          // print(element.data().runtimeType);
          final question =
              Question.fromMap(element.data() as Map<String, dynamic>);
          print(question);
          questionsList.add(question);
        },
      );
      return questionsList;
    } catch (e) {
      return [];
    }
  }
}
