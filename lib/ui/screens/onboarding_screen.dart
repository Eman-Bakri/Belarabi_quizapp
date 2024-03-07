import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app_with_eman/app/routes.dart';
import 'package:quiz_app_with_eman/ui/widgets/onboarding/animated_button_widget.dart';
import 'package:quiz_app_with_eman/ui/widgets/onboarding/animated_image_widget.dart';
import 'package:quiz_app_with_eman/ui/widgets/onboarding/animated_title_widget.dart';
import 'package:quiz_app_with_eman/ui/widgets/onboarding/animation_description_widget.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late Duration mainPlayDuration;
  late Duration starsDelayDuration;
  late Duration titleDelayDuration;
  late Duration descriptionDelayDuration;
  late Duration buttonDelayDuration;
  late Duration buttonPlayDuration;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    mainPlayDuration = 1000.ms;
    starsDelayDuration = 600.ms;
    titleDelayDuration = mainPlayDuration + 50.ms;
    descriptionDelayDuration = titleDelayDuration + 300.ms;
    buttonDelayDuration = descriptionDelayDuration + 100.ms;
    buttonPlayDuration = mainPlayDuration - 200.ms;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Flexible(child: SizedBox(height: 50)),
          Flexible(
            flex: 6,
            child: AnimatedImageWidget(
              imagePlayDuration: mainPlayDuration,
              starsDelayDuration: starsDelayDuration,
            ),
          ),
          const SizedBox(height: 30),
          Flexible(
            flex: 2,
            child: AnimatedTitleWidget(
              titleDelayDuration: titleDelayDuration,
              mainPlayDuration: mainPlayDuration,
            ),
          ),
          const SizedBox(height: 20),
          Flexible(
            flex: 2,
            child: AnimatedDescriptionWidget(
              descriptionDelayDuration: descriptionDelayDuration,
              descriptionPlayDuration: mainPlayDuration,
            ),
          ),
          Expanded(
            flex: 3,
            child: GestureDetector(
              onTap: () {
                context.go(PageName.profileRoute);
              },
              child: AnimatedButtonWidget(
                buttonDelayDuration: buttonDelayDuration,
                buttonPlayDuration: buttonPlayDuration,
              ),
            ),
          )
        ],
      ),
    );
  }
}
