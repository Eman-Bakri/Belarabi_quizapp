import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app_with_eman/ui/widgets/quiz/option_contain.dart';

import '../../../features/firestore_config/model/questions_model.dart';
import '../../../features/profile_managment/cubits/user_details_cubit.dart';
import '../home/circular_progress_container.dart';

enum LifelineStatus { unused, using, used }

class QuestionsContainer extends StatefulWidget {
  final List<GlobalKey>? audioQuestionContainerKeys;
  final int currentQuestionIndex;
  final Function submitAnswer;
  final AnimationController questionContentAnimationController;
  final AnimationController questionAnimationController;
  final Animation<double> questionSlideAnimation;
  final Animation<double> questionScaleUpAnimation;
  final Animation<double> questionScaleDownAnimation;
  final Animation<double> questionContentAnimation;
  final List<Question> questions;
  final double? topPadding;
  final String? level;
  final Map<String, LifelineStatus> lifeLines;
  final AnimationController timerAnimationController;
  final bool? showGuessTheWordHint;

  const QuestionsContainer({
    super.key,
    required this.submitAnswer,
    required this.currentQuestionIndex,
    required this.questionAnimationController,
    required this.questionContentAnimationController,
    required this.questionContentAnimation,
    required this.questionScaleDownAnimation,
    required this.questionScaleUpAnimation,
    required this.questionSlideAnimation,
    required this.questions,
    required this.lifeLines,
    this.showGuessTheWordHint,
    this.audioQuestionContainerKeys,
    required this.timerAnimationController,
    this.level,
    this.topPadding,
  });

  @override
  State<QuestionsContainer> createState() => _QuestionsContainerState();
}

class _QuestionsContainerState extends State<QuestionsContainer> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: _buildQuestions(context),
    );
  }

  List<Widget> _buildQuestions(BuildContext context) {
    List<Widget> children = [];

    //loop terminate condition will be questions.length instead of 4
    for (var i = 0; i < getQuestionsLength(); i++) {
      //add question
      children.add(_buildQuestion(i, context));
    }
    //need to reverse the list in order to display 1st question in top
    children = children.reversed.toList();

    return children;
  }

  int getQuestionsLength() {
    return widget.questions.length;
  }

  Widget _buildQuestion(int questionIndex, BuildContext context) {
    //print(questionIndex);
    //if current question index is same as question index means
    //it is current question and will be on top
    //so we need to add animation that slide and fade this question
    if (widget.currentQuestionIndex == questionIndex) {
      print("first if --------");
      return FadeTransition(
        opacity: widget.questionSlideAnimation.drive(
          Tween<double>(begin: 1.0, end: 0.0),
        ),
        child: SlideTransition(
          position: widget.questionSlideAnimation.drive(
            Tween<Offset>(begin: Offset.zero, end: const Offset(-1.5, 0.0)),
          ),
          child: _buildQuestionContainer(1.0, questionIndex, true, context),
        ),
      );
    }
    //if the question is second or after current question
    //so we need to animation that scale this question
    //initial scale of this question is 0.95

    else if (questionIndex > widget.currentQuestionIndex &&
        (questionIndex == widget.currentQuestionIndex + 1)) {
      print("second if --------");
      return AnimatedBuilder(
        animation: widget.questionAnimationController,
        builder: (context, child) {
          double scale = 0.95 +
              widget.questionScaleUpAnimation.value -
              widget.questionScaleDownAnimation.value;
          return _buildQuestionContainer(scale, questionIndex, false, context);
        },
      );
    }
    //to build question except top 2

    else if (questionIndex > widget.currentQuestionIndex) {
      print("thirt if ------");
      return _buildQuestionContainer(1.0, questionIndex, false, context);
    }
    //if the question is already animated that show empty container
    print("sizedbox if ------");
    return const SizedBox();
  }

  Widget _buildCurrentCoins() {
    return BlocBuilder<UserDetailsCubit, UserDetailsState>(
        bloc: context.read<UserDetailsCubit>(),
        builder: (context, state) {
          if (state is UserDetailsFetchSuccess) {
            return Align(
              alignment: AlignmentDirectional.topEnd,
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Coins: ",
                      style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .onTertiary
                            .withOpacity(0.5),
                        fontSize: 14,
                      ),
                    ),
                    TextSpan(
                      text: "${state.userProfile.coins}",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onTertiary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const SizedBox();
        });
  }

  Widget _buildCurrentQuestionIndex() {
    final onTertiary = Theme.of(context).colorScheme.onTertiary;
    return Align(
      alignment: Alignment.center,
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "${widget.currentQuestionIndex + 1}",
              style: TextStyle(
                color: onTertiary.withOpacity(0.5),
                fontSize: 14,
              ),
            ),
            TextSpan(
              text: " / ${widget.questions.length}",
              style: TextStyle(color: onTertiary),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionText({required String questionText}) {
    return Text(
      questionText,
      textAlign: TextAlign.center,
      style: GoogleFonts.nunito(
        textStyle: TextStyle(
          height: 1.125,
          color: Theme.of(context).colorScheme.onTertiary,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _buildOptions(Question question, BoxConstraints constraints) {
    //build options when no need to use lifeline
    print("where are heree and contain is ${question}");
    return Column(
      children: question.options.map((option) {
        return OptionContainer(
          showAnswerCorrectness: true,
          constraints: constraints,
          answerOption: option,
          correctOption: question.answer,
          submitAnswer: widget.submitAnswer,
        );
      }).toList(),
    );
  }

  Widget _buildQuestionContainer(
      double scale, int index, bool showContent, BuildContext context) {
    Widget child = LayoutBuilder(
      builder: (context, constraints) {
        if (widget.questions.isEmpty) {
          return Container();
        } else {
          Question question = widget.questions[index];
          return SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (widget.lifeLines.isNotEmpty) ...[
                      _buildCurrentCoins(),
                    ],
                    _buildCurrentQuestionIndex(),
                  ],
                ),
                const SizedBox(height: 20.0),
                Container(
                  alignment: Alignment.center,
                  child: _buildQuestionText(
                    questionText: question.qst,
                  ),
                ),
                question.imageUrl != null && question.imageUrl!.isNotEmpty
                    ? SizedBox(height: constraints.maxHeight * (0.0175))
                    : SizedBox(height: constraints.maxHeight * (0.02)),
                question.imageUrl != null && question.imageUrl!.isNotEmpty
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        height: constraints.maxHeight * 0.325,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: CachedNetworkImage(
                          placeholder: (_, __) => const Center(
                            child: CircularProgressContainer(),
                          ),
                          imageUrl: question.imageUrl!,
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            );
                          },
                          errorWidget: (_, i, e) {
                            return Center(
                              child: Icon(
                                Icons.error,
                                color: Theme.of(context).primaryColor,
                              ),
                            );
                          },
                        ),
                      )
                    : const SizedBox(),
                _buildOptions(question, constraints),
                const SizedBox(height: 5),
              ],
            ),
          );
        }
      },
    );

    return Container(
      transform: Matrix4.identity()..scale(scale),
      transformAlignment: Alignment.center,
      // padding: const EdgeInsets.symmetric(horizontal: 15.0),
      width: MediaQuery.of(context).size.width * 0.90,
      height: MediaQuery.of(context).size.height * 0.785,
      child: showContent
          ? SlideTransition(
              position: widget.questionContentAnimation.drive(Tween<Offset>(
                  begin: const Offset(0.5, 0.0), end: Offset.zero)),
              child: FadeTransition(
                opacity: widget.questionContentAnimation,
                child: child,
              ),
            )
          : const SizedBox(),
      // decoration: BoxDecoration(
      //     // color: Theme.of(context).backgroundColor,
      //     borderRadius: BorderRadius.circular(25)),
    );
  }
}
