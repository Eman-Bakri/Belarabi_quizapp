// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedNameWidget extends StatelessWidget {
  final Duration namePlayDuration;
  final Duration nameDelayDuration;
  final String name;
  const AnimatedNameWidget({
    Key? key,
    required this.namePlayDuration,
    required this.name,
    required this.nameDelayDuration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // context.setLocale(Locale('en'));
    print("language is " + context.locale.toString());
    return Text(
      "hello_message",
      maxLines: 2,
      style: Theme.of(context)
          .textTheme
          .headlineSmall!
          .copyWith(color: Theme.of(context).colorScheme.onTertiary),
    )
        .tr(args: [name])
        .animate()
        .slideX(
          begin: 0.2,
          end: 0,
          duration: namePlayDuration,
          delay: nameDelayDuration,
          curve: Curves.fastOutSlowIn,
        )
        .fadeIn();
  }
}
