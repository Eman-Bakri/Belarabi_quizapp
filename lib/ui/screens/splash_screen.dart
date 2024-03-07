import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app_with_eman/app/routes.dart';
import 'package:quiz_app_with_eman/features/systemConfig/cubits/system_config_cubit.dart';
import 'package:quiz_app_with_eman/utils/ui_utils.dart';

import '../../features/settings/settings_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  )..addStatusListener(animationStatusListner);

  late AnimationController logoAnimationController;
  late Animation<double> logoScaleUpAnimation;
  late Animation<double> logoScaleDownAnimation;

  void animationStatusListner(AnimationStatus animationStatus) {
    if (animationStatus == AnimationStatus.completed) {}
  }

  late bool loadedSystemConfigDetails = false;

  @override
  void initState() {
    super.initState();
    initAnimations();
    loadSystemConfig();
  }

  void loadSystemConfig() {
    context.read<SystemConfigCubit>().getSystemConfig();
  }

  void initAnimations() {
    startAnimation();

    logoAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    logoScaleUpAnimation = Tween(begin: 0.0, end: 1.1).animate(
      CurvedAnimation(
        parent: logoAnimationController,
        curve: const Interval(0.0, 0.4),
      ),
    );
    logoScaleDownAnimation = Tween(begin: 0.0, end: 0.1).animate(
      CurvedAnimation(
        parent: logoAnimationController,
        curve: const Interval(0.4, 1.0, curve: Curves.easeInOut),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    animationController.removeStatusListener(animationStatusListner);
    animationController.dispose();
    logoAnimationController.dispose();
  }

  void startAnimation() async {
    await animationController.forward(from: 0.0);
    // await clockAnimationController.forward(from: 0.0);
    await logoAnimationController.forward(from: 0.0);
    navigateToNextScreen();
  }

  void navigateToNextScreen() {
    if (loadedSystemConfigDetails) {
      print('where are not here');
      final currentSettings = context.read<SettingsCubit>().state.settingsModel;
      if (currentSettings!.showIntroSlider) {
        context.go(PageName.introSliderRoute);
      } else {
        context.go(PageName.homeRoute);
      }
    }
  }

  Widget _buildSplashAnimation() {
    return Stack(
      children: [
        AnimatedBuilder(
          animation: logoAnimationController,
          builder: (context, child) {
            double scale =
                0.0 + logoScaleUpAnimation.value - logoScaleDownAnimation.value;
            return Transform.scale(
              scale: scale,
              child: child,
            );
          },
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.2,
            ),
            child: Center(
              child: Image.asset(
                UiUtils.getImagePath("splash_logo.png"),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Stack(
          children: [
            BlocConsumer<SystemConfigCubit, SystemConfigState>(
              listener: (context, state) {
                if (state is SystemConfigFetchSuccess) {
                  if (!logoAnimationController.isCompleted) {
                    loadedSystemConfigDetails = true;
                  } else {
                    loadedSystemConfigDetails = true;
                    navigateToNextScreen();
                  }
                }
              },
              builder: (context, state) {
                Widget child = Center(
                  key: const Key("splashAnimation"),
                  child: _buildSplashAnimation(),
                );
                if (state is SystemConfigFetchFailure) {
                  print("state failed");
                  child = Scaffold(
                    body: Center(
                      child: Container(
                        height: 100,
                        width: 100,
                        color: Colors.red,
                        child: const Text("fail Screen"),
                      ),
                    ),
                  );
                }

                return AnimatedSwitcher(
                  duration: const Duration(
                    seconds: 1,
                  ),
                  child: child,
                );
              },
            )
          ],
        ));
  }
}
