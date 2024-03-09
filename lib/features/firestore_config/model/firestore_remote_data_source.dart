import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_app_with_eman/features/firestore_config/model/questions_model.dart';

class FirestoreRemoteDataSource {
  Future<List<Question>> fetchAllQuestions({
    required String language,
    required String category,
    required String subCategory,
    required String level,
  }) async {
    final firestore = FirebaseFirestore.instance;

    print("where are here");

    List<Question> questionsList = [];
    QuerySnapshot querySnapshotArabic = await firestore
        .collection("quiz_arabic")
        .doc("اللهجات المحلية")
        .collection("المغرب")
        .doc("مستوى 1")
        .collection("Questions")
        .get();

    print(
        "category: $category, subCategory:$subCategory, language: $language,level: $level");
    QuerySnapshot querySnapshot = await firestore
        .collection("Quiz")
        .doc(category)
        .collection(subCategory)
        .doc("Level 1")
        .collection("Questions")
        .get();
    (language == "arabic" ? querySnapshotArabic : querySnapshot).docs.forEach(
      (element) {
        // print(element.data().runtimeType);
        final question =
            Question.fromMap(element.data() as Map<String, dynamic>);
        print(question);
        questionsList.add(question);
      },
    );
    print("---------------------");
    print(questionsList);
    print("---------------------");
    return questionsList;
  }
}
