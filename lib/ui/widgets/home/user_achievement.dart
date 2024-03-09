// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../utils/constants/fonts.dart';

class UserAchievements extends StatelessWidget {
  final String userRank;
  final String userCoins;
  final Duration userAchievementDelayDuration;
  final Duration userAchievementPlayDuration;
  const UserAchievements({
    Key? key,
    this.userRank = "0",
    this.userCoins = "0",
    required this.userAchievementDelayDuration,
    required this.userAchievementPlayDuration,
  }) : super(key: key);

  static const _verticalDivider = VerticalDivider(
    color: Color(0x99FFFFFF),
    indent: 12,
    endIndent: 14,
    thickness: 2,
  );

  @override
  Widget build(BuildContext context) {
    final rank = "Rank";
    final coins = "Coins";

    return LayoutBuilder(
      builder: (_, constraints) {
        final size = MediaQuery.of(context).size;
        return Stack(
          children: [
            Positioned(
              top: 0,
              left: constraints.maxWidth * (0.05),
              right: constraints.maxWidth * (0.05),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 25),
                      blurRadius: 30,
                      spreadRadius: 3,
                      color: Theme.of(context).primaryColor.withOpacity(0.5),
                    )
                  ],
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(constraints.maxWidth * (0.525)),
                  ),
                ),
                width: constraints.maxWidth,
                height: 70,
              ),
            ),
            Positioned(
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 8.5,
                  horizontal: 20,
                ),
                margin: EdgeInsets.symmetric(
                  vertical: size.height * .02,
                  horizontal: size.width * .04,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _Achievement(title: rank, value: userRank),
                    _verticalDivider,
                    _Achievement(title: coins, value: userCoins),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    ).animate().scaleXY(
        begin: 0,
        end: 1,
        duration: userAchievementPlayDuration,
        delay: userAchievementDelayDuration,
        curve: Curves.easeInOutSine);
  }
}

class _Achievement extends StatelessWidget {
  const _Achievement({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeights.bold,
            color: Colors.white.withOpacity(0.7),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 21.0,
            fontWeight: FontWeights.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
