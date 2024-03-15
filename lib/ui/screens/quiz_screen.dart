// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app_with_eman/features/firestore_config/firestore_cubit.dart';
import 'package:quiz_app_with_eman/ui/widgets/quiz/custom_appbar.dart';
import 'package:quiz_app_with_eman/ui/widgets/quiz/questions_container.dart';

import '../../features/systemConfig/cubits/system_config_cubit.dart';
import '../../utils/constants/constants.dart';
import '../widgets/profile/error_container.dart';
import '../widgets/quiz/exit_quiz_dialog.dart';
import '../widgets/quiz/text_circular_timer.dart';

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

class _QuizAppState extends State<QuizScreen> with TickerProviderStateMixin {
  bool isExitDialogOpen = false;
  late AnimationController timerAnimationController;
  int currentQuestionIndex = 0;
  int numCorrectAnswer = 0;

  late AnimationController questionAnimationController;
  late AnimationController questionContentAnimationController;
  late Animation<double> questionSlideAnimation;
  late Animation<double> questionScaleUpAnimation;
  late Animation<double> questionScaleDownAnimation;
  late Animation<double> questionContentAnimation;
  late AnimationController animationController;
  late AnimationController topContainerAnimationController;

  late Map<String, LifelineStatus> lifelines = {
    "fiftyFifty": LifelineStatus.unused,
    "audiencePoll": LifelineStatus.unused,
    skip: LifelineStatus.unused,
    resetTime: LifelineStatus.unused,
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeAnimation();
    timerAnimationController = AnimationController(
      vsync: this,
      reverseDuration: const Duration(seconds: inBetweenQuestionTimeInSeconds),
      duration: Duration(
        seconds: context.read<SystemConfigCubit>().getQuizTime(),
      ),
    )..addStatusListener(currentUserTimerAnimationStatusListener);
    context.read<FirestoreCubit>().fetchDataFromFirestore(
          isArabic: widget.language == 'ar' ? true : false,
          category: widget.category ?? "",
          subCategory: widget.subCategory ?? "",
          level: widget.level ?? "",
        );
  }

  void initializeAnimation() {
    questionContentAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
    questionAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 525));
    questionSlideAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: questionAnimationController, curve: Curves.easeInOut));
    questionScaleUpAnimation = Tween<double>(begin: 0.0, end: 0.1).animate(
        CurvedAnimation(
            parent: questionAnimationController,
            curve: const Interval(0.0, 0.5, curve: Curves.easeInQuad)));
    questionContentAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: questionContentAnimationController,
            curve: Curves.easeInQuad));
    questionScaleDownAnimation = Tween<double>(begin: 0.0, end: 0.05).animate(
        CurvedAnimation(
            parent: questionAnimationController,
            curve: const Interval(0.5, 1.0, curve: Curves.easeOutQuad)));
  }

  @override
  void dispose() {
    timerAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FirestoreCubit, FirestoreConfigState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is FirestoreConfigFetchInProgress ||
              state is FirestoreConfigFetchInProgress) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (state is FirestoreConfigFetchFailer) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
              ),
              body: Center(
                child: ErrorContainer(
                  errorMessage: state.errorMessage,
                  onTapRetry: () {
                    context.read<FirestoreCubit>().fetchDataFromFirestore(
                          isArabic: widget.language == 'ar' ? true : false,
                          category: widget.category ?? "",
                          subCategory: widget.subCategory ?? "",
                          level: widget.level ?? "",
                        );
                  },
                  showErrorImage: true,
                ),
              ),
            );
          }
          Future.delayed(const Duration(seconds: 2)).then((value) {
            timerAnimationController.forward(from: 0.0);
          });
          questionContentAnimationController.forward();
          return WillPopScope(
            onWillPop: () {
              onTapBackButton();

              return Future.value(false);
            },
            child: Scaffold(
              appBar: QAppBar(
                onTapBackButton: () {
                  onTapBackButton();
                  return Future.value(true);
                },
                roundedAppBar: false,
                title: TextCircularTimer(
                  animationController: timerAnimationController,
                  arcColor: Theme.of(context).primaryColor,
                  color:
                      Theme.of(context).colorScheme.onTertiary.withOpacity(0.2),
                ),
              ),
              body: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    QuestionsContainer(
                        submitAnswer: submitAnswer,
                        currentQuestionIndex: currentQuestionIndex,
                        questionAnimationController:
                            questionAnimationController,
                        questionContentAnimationController:
                            questionContentAnimationController,
                        questionContentAnimation: questionContentAnimation,
                        questionScaleDownAnimation: questionScaleDownAnimation,
                        questionScaleUpAnimation: questionScaleUpAnimation,
                        questionSlideAnimation: questionSlideAnimation,
                        questions: context.read<FirestoreCubit>().questions(),
                        lifeLines: lifelines,
                        timerAnimationController: timerAnimationController)
                  ],
                ),
              ),
            ),
          );
        });
  }

  void onTapBackButton() {
    isExitDialogOpen = true;
    showDialog(
      context: context,
      builder: (_) => ExitQuizDialog(onTapYes: () {
        Navigator.of(context).pop(true);
        Navigator.of(context).pop(true);
      }),
    ).then(
      (_) {},
    );
  }

  void currentUserTimerAnimationStatusListener(AnimationStatus status) {
    print(status.toString());
    if (status == AnimationStatus.completed) {
      print("User has left the question so submit answer as -1");
      submitAnswer(false);
    } else if (status == AnimationStatus.forward) {}
  }

  void submitAnswer(bool isCorrectAnswer) async {
    timerAnimationController.reverse();
    await Future.delayed(
        const Duration(seconds: inBetweenQuestionTimeInSeconds));
    if (isCorrectAnswer) numCorrectAnswer++;
    if (currentQuestionIndex !=
        (context.read<FirestoreCubit>().questions().length - 1)) {
      changeQuestion();
      timerAnimationController.forward(from: 0.0);
    } else {
      navigateToResultScreen();
    }
  }

  void changeQuestion() {
    print("NextQuestion");
    questionAnimationController.forward(from: 0.0).then((value) {
      //need to dispose the animation controllers
      questionAnimationController.dispose();
      questionContentAnimationController.dispose();
      //initializeAnimation again
      setState(() {
        initializeAnimation();
        print("currentQuestion is $currentQuestionIndex");
        currentQuestionIndex++;
      });
      //load content(options, image etc) of question
      questionContentAnimationController.forward();
    });
  }

  void navigateToResultScreen() {
    context.go("/home/result",
        extra: {"numCorrectAnswer": numCorrectAnswer.toString()});
  }
}
