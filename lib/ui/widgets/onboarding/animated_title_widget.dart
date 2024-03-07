// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:quiz_app_with_eman/utils/constants/fonts.dart';

class AnimatedTitleWidget extends StatelessWidget {
  final Duration titleDelayDuration;
  final Duration mainPlayDuration;
  const AnimatedTitleWidget({
    Key? key,
    required this.titleDelayDuration,
    required this.mainPlayDuration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Text.rich(
          textAlign: TextAlign.center,
          TextSpan(
            style: Theme.of(context).textTheme.displaySmall,
            children: const [
              TextSpan(
                text: "Journey Through \n",
              ),
              TextSpan(
                text: "Arabic Dialects",
                style: TextStyle(
                  color: Colors.amber,
                  fontWeight: FontWeights.bold,
                ),
              )
            ],
          ),
        ),
      ),
    )
        .animate()
        .slideY(
          begin: -0.2,
          end: 0,
          delay: titleDelayDuration,
          duration: mainPlayDuration,
          curve: Curves.easeInOutCubic,
        )
        .scaleXY(
          begin: 0,
          end: 1,
          delay: titleDelayDuration,
          duration: mainPlayDuration,
          curve: Curves.easeInOutCubic,
        );
  }
}
