// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app_with_eman/app/routes.dart';
import 'package:quiz_app_with_eman/features/profile_managment/cubits/user_details_cubit.dart';
import 'package:quiz_app_with_eman/ui/widgets/home/animated_name_widget.dart';
import 'package:quiz_app_with_eman/utils/ui_utils.dart';

class AnimatedAppBarWidget extends StatelessWidget {
  final Duration avatarWaitingDuration;
  final Duration avatarPlayDuration;
  final Duration nameDelayDuration;
  final Duration namePlayDuration;
  final Duration settingPlayDuration;
  final Duration settingDelayDuration;
  const AnimatedAppBarWidget({
    Key? key,
    required this.avatarWaitingDuration,
    required this.avatarPlayDuration,
    required this.nameDelayDuration,
    required this.namePlayDuration,
    required this.settingPlayDuration,
    required this.settingDelayDuration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProfile =
        (context.read<UserDetailsCubit>().state as UserDetailsFetchSuccess)
            .userProfile;
    return Row(
      children: [
        const SizedBox(width: 30),
        GestureDetector(
          onTap: () {
            context.push(PageName.profileRoute);
          },
          child: CircleAvatar(
            radius: 18,
            backgroundColor: Colors.blue.shade900,
            child: Image.asset(
                UiUtils.getProfileImagePath(userProfile.profileAvatar!)),
          )
              .animate()
              .scaleXY(
                  begin: 0,
                  end: 2,
                  duration: avatarPlayDuration,
                  curve: Curves.easeInOutSine)
              .then(delay: avatarWaitingDuration)
              .scaleXY(begin: 3, end: 1)
              .slide(begin: const Offset(4, 6), end: Offset.zero),
        ),
        const SizedBox(
          width: 25,
        ),
        AnimatedNameWidget(
          namePlayDuration: namePlayDuration,
          nameDelayDuration: nameDelayDuration,
          name: userProfile.name ?? "",
        ),
        const Spacer(),
        Container(
          width: MediaQuery.of(context).size.width * 0.11,
          height: MediaQuery.of(context).size.width * 0.11,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              UiUtils.getImagePath("settings.svg"),
              color: Colors.white,
              width: MediaQuery.of(context).size.width * 0.08,
              height: MediaQuery.of(context).size.width * 0.08,
            ),
          ),
        ).animate().slideX(
              begin: 4,
              end: 0,
              duration: settingPlayDuration,
              delay: settingDelayDuration,
              curve: Curves.fastOutSlowIn,
            ),
        SizedBox(
          width: 10,
        )
      ],
    );
  }
}
