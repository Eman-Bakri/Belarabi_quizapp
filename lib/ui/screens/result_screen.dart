// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_app_with_eman/features/profile_managment/models/user_profile.dart';

import '../../features/profile_managment/cubits/user_details_cubit.dart';
import '../../utils/constants/constants.dart';
import '../../utils/constants/fonts.dart';
import '../../utils/ui_utils.dart';
import '../../utils/user_utils.dart';
import '../widgets/quiz/custom_appbar.dart';
import '../widgets/result/radial_result_container.dart';

class ResultScreen extends StatefulWidget {
  final int numCorrectAnswer;
  const ResultScreen({
    Key? key,
    required this.numCorrectAnswer,
  }) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late bool _isWinner;

  updateProfileCoins() {
    final userCubit = context.read<UserDetailsCubit>();
    final UserProfile profile = userCubit.getUserProfile();
    final int newCoinValue =
        int.parse(profile.coins ?? "0") + (widget.numCorrectAnswer * 10);
    final int newRankValue = newCoinValue ~/ 100;
    userCubit.updateUserProfile(
      coins: newCoinValue.toString(),
      allTimeRank: newRankValue.toString(),
    );
  }

  @override
  void initState() {
    super.initState();
    updateProfileCoins();
    if (winPercentage() >= winPercentageBreakPoint) {
      _isWinner = true;
    } else {
      _isWinner = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: QAppBar(
        roundedAppBar: false,
        title: Text("Quiz Result"),
        onTapBackButton: () {
          Navigator.pop(context);
        },
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(child: _buildResultContainer(context)),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultContainer(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * (0.560),
      width: MediaQuery.of(context).size.width * (0.90),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onTertiary.withOpacity(.05),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: _buildResultDetails(context),
    );
  }

  Widget _buildResultDetails(BuildContext context) {
    final userProfileUrl = UiUtils.getProfileImagePath(
        context.read<UserDetailsCubit>().getUserProfile().profileAvatar ?? "");

    return _buildIndividualResultContainer(userProfileUrl);
  }

  Widget _buildIndividualResultContainer(String userProfileUrl) {
    String lottieAnimation = _isWinner
        ? "assets/animations/confetti.json"
        : "assets/animations/defeats.json";

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Lottie.asset(lottieAnimation, fit: BoxFit.fill),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: LayoutBuilder(
            builder: (context, constraints) {
              double verticalSpacePercentage = 0.0;

              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildGreetingMessage(context),
                  SizedBox(
                    height: constraints.maxHeight * verticalSpacePercentage,
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      UserUtils.getUserProfileWidget(
                        profileUrl: userProfileUrl,
                        width: 107,
                        height: 107,
                        // height: constraints.maxHeight *
                        //     (profileRadiusPercentage - 0.079),
                        // width: constraints.maxWidth *
                        //     (profileRadiusPercentage - 0.079 + 0.15),
                      ),
                      SvgPicture.asset(
                        UiUtils.getImagePath("hexagon_frame.svg"),
                        width: 132,
                        height: 132,
                        // height: constraints.maxHeight *
                        //     (profileRadiusPercentage),
                        // width: constraints.maxWidth *
                        //     (profileRadiusPercentage - 0.05 + 0.15),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),

        //incorrect answer
        Align(
          alignment: AlignmentDirectional.bottomStart,
          child: _buildResultDataWithIconContainer(
            "${10 - widget.numCorrectAnswer}/10",
            "wrong.svg",
            EdgeInsetsDirectional.only(
              start: 15.0,
              bottom: 30.0,
            ),
          ),
        ),
        //correct answer
        Align(
          alignment: context.locale.languageCode == 'en'
              ? Alignment.bottomRight
              : Alignment.bottomLeft,
          child: _buildResultDataWithIconContainer(
            "${widget.numCorrectAnswer}/10",
            "correct.svg",
            const EdgeInsetsDirectional.only(end: 15.0, bottom: 30.0),
          ),
        ),

        //build radils percentage container
        Align(
          alignment: Alignment.bottomCenter,
          child: LayoutBuilder(
            builder: (context, constraints) {
              double radialSizePercentage = 0.0;
              if (constraints.maxHeight <
                  UiUtils.profileHeightBreakPointResultScreen) {
                radialSizePercentage = 0.4;
              } else {
                radialSizePercentage = 0.325;
              }
              return Transform.translate(
                offset: const Offset(0.0, 15.0),
                child: RadialPercentageResultContainer(
                  percentage: winPercentage(),
                  size: Size(
                    constraints.maxHeight * radialSizePercentage,
                    constraints.maxHeight * radialSizePercentage,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildGreetingMessage(BuildContext context) {
    final String title;
    final String message;

    final scorePct = winPercentage();

    if (scorePct <= 30) {
      title = "Good Effort";
      message = "Keep Learning";
    } else if (scorePct <= 50) {
      title = "Well Done";
      message = "Making Progress";
    } else if (scorePct <= 70) {
      title = "Great Job";
      message = "Closer ToMastery";
    } else if (scorePct <= 90) {
      title = "ExcellentWork";
      message = "Keep Going";
    } else {
      title = "Fantastic Job";
      message = "Achieved Mastery";
    }

    final titleStyle = TextStyle(
      fontSize: 26,
      color: Theme.of(context).colorScheme.onTertiary,
      fontWeight: FontWeights.bold,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 30.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          alignment: Alignment.center,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: titleStyle,
              ),
            ],
          ),
        ),
        const SizedBox(height: 5.0),
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.shortestSide * .85,
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 19.0,
              color: Theme.of(context).colorScheme.onTertiary,
            ),
          ),
        ),
      ],
    );
  }

  double winPercentage() {
    return (widget.numCorrectAnswer * 100.0) / 10;
  }

  Widget _buildResultDataWithIconContainer(
    String title,
    String icon,
    EdgeInsetsGeometry margin,
  ) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      // padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * (0.2125),
      height: 33.0,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            UiUtils.getImagePath(icon),
            color: Theme.of(context).colorScheme.onTertiary,
            width: 19,
            height: 19,
          ),
          const SizedBox(width: 6),
          Text(
            title,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onTertiary,
              fontWeight: FontWeights.bold,
              fontSize: 18,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
