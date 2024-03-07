// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../utils/ui_utils.dart';

class AnimatedImageWidget extends StatelessWidget {
  final Duration imagePlayDuration;
  final Duration starsDelayDuration;
  const AnimatedImageWidget({
    Key? key,
    required this.imagePlayDuration,
    required this.starsDelayDuration,
  }) : super(key: key);

  @override
  Widget build(context) {
    return Stack(
      children: [
        // thirt one -----------------------
        Positioned(
          top: 15,
          right: -20,
          child: Transform.rotate(
            angle: 2 * pi * 0.90,
            child: Image.asset(
              UiUtils.getImagePath("stars.png"),
              height: 150,
            ),
          ),
        )
            .animate()
            .scaleXY(
                delay: starsDelayDuration,
                begin: 0,
                end: 1,
                duration: imagePlayDuration,
                curve: Curves.decelerate)
            .slide(begin: const Offset(-0.7, 1), end: Offset.zero),
        Positioned(
          top: 10,
          left: 0,
          child: Transform.rotate(
            angle: 2 * pi * 0.75,
            child: Image.asset(
              UiUtils.getImagePath("stars.png"),
              height: 150,
            ),
          ),
        )
            .animate()
            .scaleXY(
                delay: starsDelayDuration,
                begin: 0,
                end: 1,
                duration: imagePlayDuration,
                curve: Curves.decelerate)
            .slide(begin: const Offset(0.7, 1), end: Offset.zero),
        Container(
          // color: Colors.yellow,
          margin: EdgeInsets.only(
            top: 100,
          ),
          alignment: Alignment.topCenter,
          child: Image.asset(
            UiUtils.getImagePath("splash_logo.png"),
            height: 200,
            fit: BoxFit.contain,
          ),
        ).animate().scaleXY(
              begin: 0,
              end: 1,
              duration: imagePlayDuration,
              curve: Curves.easeInOutCubic,
            )
      ],
    );
  }
}
