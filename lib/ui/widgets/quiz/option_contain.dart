import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quiz_app_with_eman/features/firestore_config/model/options_model.dart';

import '../../../utils/constants/constants.dart';
import '../../../utils/ui_utils.dart';

class OptionContainer extends StatefulWidget {
  final Function submitAnswer;
  final Options answerOption;
  final BoxConstraints constraints;
  final String correctOption;
  final bool showAnswerCorrectness;

  const OptionContainer({
    super.key,
    required this.showAnswerCorrectness,
    required this.constraints,
    required this.answerOption,
    required this.correctOption,
    required this.submitAnswer,
  });

  @override
  State<OptionContainer> createState() => _OptionContainerState();
}

class _OptionContainerState extends State<OptionContainer>
    with TickerProviderStateMixin {
  late final animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 90),
  );
  late Animation<double> animation = Tween<double>(begin: 0.0, end: 1.0)
      .animate(CurvedAnimation(
          parent: animationController, curve: Curves.easeInQuad));

  late AnimationController topContainerAnimationController =
      AnimationController(
          vsync: this, duration: const Duration(milliseconds: 180));
  late Animation<double> topContainerOpacityAnimation =
      Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
    parent: topContainerAnimationController,
    curve: const Interval(0.0, 0.25, curve: Curves.easeInQuad),
  ));

  late Animation<double> topContainerAnimation =
      Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: topContainerAnimationController,
          curve: const Interval(0.0, 0.5, curve: Curves.easeInQuad)));

  late Animation<double> answerCorrectnessAnimation =
      Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: topContainerAnimationController,
          curve: const Interval(0.5, 1.0, curve: Curves.easeInQuad)));

  late double heightPercentage = 0.105;
  late final _audioPlayer = AudioPlayer();

  late TextSpan textSpan = TextSpan(
    text: widget.answerOption.title,
    style: GoogleFonts.nunito(
      textStyle: TextStyle(
        color: Theme.of(context).colorScheme.background,
        height: 1.0,
        fontSize: 16.0,
      ),
    ),
  );

  @override
  void dispose() {
    animationController.dispose();
    topContainerAnimationController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  void playSound(String trackName) async {
    // if (context.read<SettingsCubit>().getSettings().sound) {
    if (_audioPlayer.playing) {
      await _audioPlayer.stop();
    }
    await _audioPlayer.setAsset(trackName, preload: true);
    await _audioPlayer.play();
    // }
  }

  void playVibrate() async {
    // if (context.read<SettingsCubit>().getSettings().vibration) {
    UiUtils.vibrate();
    // }
  }

  int calculateMaxLines() {
    TextPainter textPainter =
        TextPainter(text: textSpan, textDirection: Directionality.of(context));

    textPainter.layout(maxWidth: widget.constraints.maxWidth * 0.85);

    return textPainter.computeLineMetrics().length;
  }

  Color _buildOptionBackgroundColor() {
    if (widget.showAnswerCorrectness) {
      return Theme.of(context).colorScheme.background;
    }
    // if (widget.hasSubmittedAnswerForCurrentQuestion() &&
    //     widget.submittedAnswerId == widget.answerOption.title) {
    //   print("Submitted answer id is : ${widget.submittedAnswerId}");
    //   print("Stop here");

    return Theme.of(context).primaryColor;
    // }

    // return Theme.of(context).colorScheme.background;
  }

  void _onTapOptionContainer() {
    if (widget.showAnswerCorrectness) {
      //if user has submitted the answer then do not show correctness of the answer
      if (true) {
        widget.submitAnswer(widget.correctOption == widget.answerOption.title);

        topContainerAnimationController.forward();

        if (widget.correctOption == widget.answerOption.title) {
          playSound(correctAnswerSoundTrack);
        } else {
          playSound(wrongAnswerSoundTrack);
        }
        playVibrate();
      }
    } else {
      widget.submitAnswer(widget.answerOption.title);

      playSound(clickEventSoundTrack);
      playVibrate();
    }
  }

  Widget _buildOptionDetails(double optionWidth) {
    int maxLines = calculateMaxLines();

    return AnimatedBuilder(
      animation: animationController,
      builder: (_, child) {
        return Transform.scale(
          scale: animation.drive(Tween<double>(begin: 1.0, end: 0.9)).value,
          child: child,
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: widget.constraints.maxHeight * (0.015)),
        height: widget.constraints.maxHeight * (heightPercentage),
        width: optionWidth,
        alignment: Alignment.center,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: maxLines > 2 ? 7.50 : 0,
                ),
                color: _buildOptionBackgroundColor(),
                alignment: AlignmentDirectional.centerStart,
                child: Center(
                    child: RichText(
                  text: textSpan,
                  textAlign: TextAlign.center,
                )),
              ),
              if (widget.showAnswerCorrectness) ...[
                IgnorePointer(
                  ignoring: true,
                  child: AnimatedBuilder(
                    builder: (context, child) {
                      final height = topContainerAnimation
                          .drive(Tween<double>(
                              begin: 0.085, end: heightPercentage))
                          .value;
                      final width = topContainerAnimation
                          .drive(Tween<double>(begin: 0.2, end: 1.0))
                          .value;

                      final borderRadius = topContainerAnimation
                          .drive(Tween<double>(begin: 40.0, end: 10))
                          .value;

                      return Opacity(
                        opacity: topContainerOpacityAnimation.value,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(borderRadius),
                          ),
                          width: optionWidth * width,
                          height: widget.constraints.maxHeight * height,
                          child: Transform.scale(
                            scale: answerCorrectnessAnimation.value,
                            child: Opacity(
                              opacity: answerCorrectnessAnimation.value,
                              child: Icon(
                                widget.answerOption.title ==
                                        widget.correctOption
                                    ? Icons.check
                                    : Icons.close,
                                color: Theme.of(context).colorScheme.background,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    animation: topContainerAnimationController,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    textSpan = TextSpan(
      text: widget.answerOption.title,
      style: GoogleFonts.nunito(
        textStyle: TextStyle(
          color: Theme.of(context).colorScheme.onTertiary,
          height: 1.0,
          fontSize: 16.0,
        ),
      ),
    );
    return GestureDetector(
      onTapCancel: animationController.reverse,
      onTap: () async {
        animationController.reverse();
        _onTapOptionContainer();
      },
      onTapDown: (_) => animationController.forward(),
      child: _buildOptionDetails(widget.constraints.maxWidth),
    );
  }
}
