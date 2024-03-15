// //State
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';


// import '../firestore_config/model/questions_model.dart';
// import 'mode/quiz_type.dart';

// @immutable
// abstract class QuestionsState {}

// class QuestionsIntial extends QuestionsState {}

// class QuestionsFetchInProgress extends QuestionsState {

// }

// class QuestionsFetchFailure extends QuestionsState {
//   final String errorMessage;

//   QuestionsFetchFailure(this.errorMessage);
// }

// class QuestionsFetchSuccess extends QuestionsState {
//   final List<Question> questions;

//   QuestionsFetchSuccess(
//       {required this.questions,
//       });
// }

// class QuestionsCubit extends Cubit<QuestionsState> {
//   // final QuizRepository _quizRepository;

//   QuestionsCubit() : super(QuestionsIntial());

//   void updateState(QuestionsState newState) {

//   }

//   getQuestions(
//     QuizTypes quizType, {
//     String? userId, //will be in use for dailyQuiz
//     String? languageId, //
//     String?
//         categoryId, //will be in use for quizZone and self-challenge (quizType)
//     String?
//         subcategoryId, //will be in use for quizZone and self-challenge (quizType)
//     String? numberOfQuestions, //will be in use forself-challenge (quizType),
//     String? level, //will be in use for quizZone (quizType)
//     String? contestId,
//     String? funAndLearnId,
//   }) {
//     emit(QuestionsFetchInProgress());
//     _quizRepository
//         .getQuestions(quizType,
//             languageId: languageId,
//             categoryId: categoryId,
//             numberOfQuestions: numberOfQuestions,
//             subcategoryId: subcategoryId,
//             level: level,
//             contestId: contestId,
//             userId: userId,
//             funAndLearnId: funAndLearnId)
//         .then(
//       (questions) {
//         emit(QuestionsFetchSuccess(
//             currentPoints: 0, questions: questions, quizType: quizType));
//       },
//     ).catchError((e) {
//       emit(QuestionsFetchFailure(e.toString()));
//     });
//   }

//   //submitted AnswerId will contain -1, 0 or optionId (a,b,c,d,e)
//   void updateQuestionWithAnswerAndLifeline(String? questionId,
//       String submittedAnswerId, String firebaseId, int correctpoints) {
//     //fethcing questions that need to update
//     List<Question> updatedQuestions =
//         (state as QuestionsFetchSuccess).questions;
//     //fetching index of question that need to update with submittedAnswer
//     int questionIndex =
//         updatedQuestions.indexWhere((element) => element.id == questionId);
//     //update question at given questionIndex with submittedAnswerId
//     updatedQuestions[questionIndex] = updatedQuestions[questionIndex]
//         .updateQuestionWithAnswer(submittedAnswerId: submittedAnswerId);
//     //update points
//     int updatedPoints = (state as QuestionsFetchSuccess).currentPoints;

    
//     }

//     //update state with updatedQuestions, updatedPoints and lifelines
//     emit(
//       QuestionsFetchSuccess(
//           questions: updatedQuestions,
//           currentPoints: updatedPoints,
//           quizType: (state as QuestionsFetchSuccess).quizType),
//     );
//   }

//   void deductPointsForLeavingQuestion() {
//     if (state is QuestionsFetchSuccess) {
//       QuestionsFetchSuccess currentState = state as QuestionsFetchSuccess;
//       emit(QuestionsFetchSuccess(
//           questions: currentState.questions,
//           currentPoints: currentState.currentPoints - 2,
//           quizType: currentState.quizType));
//     }
//   }

//   int getTotalQuestionInNumber() {
//     if (state is QuestionsFetchSuccess) {
//       return (state as QuestionsFetchSuccess).questions.length;
//     }
//     return 0;
//   }

//   int currentPoints() {
//     if (state is QuestionsFetchSuccess) {
//       return (state as QuestionsFetchSuccess).currentPoints;
//     }
//     return 0;
//   }

//   List<Question> questions() {
//     if (state is QuestionsFetchSuccess) {
//       return (state as QuestionsFetchSuccess).questions;
//     }
//     return [];
//   }
// }
