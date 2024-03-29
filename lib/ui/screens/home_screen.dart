import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app_with_eman/features/profile_managment/cubits/user_details_cubit.dart';
import 'package:quiz_app_with_eman/ui/widgets/home/animated_appbar_widget.dart';
import 'package:quiz_app_with_eman/ui/widgets/home/cards_list.dart';
import 'package:quiz_app_with_eman/ui/widgets/home/user_achievement.dart';
import 'package:quiz_app_with_eman/utils/constants/constants.dart';
import 'package:quiz_app_with_eman/utils/ui_utils.dart';

import '../widgets/home/circular_progress_container.dart';
import '../widgets/profile/error_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUserDetails();
    initAnimations();
  }

  void initAnimations() {}

  void fetchUserDetails() {
    context.read<UserDetailsCubit>().fetchUserDetails();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print("yess we do change");
  }

  @override
  Widget build(BuildContext context) {
    final avatarPlayDuration = 500.ms;
    final avatarWaitingDuration = 400.ms;
    final nameDelayDuration =
        avatarWaitingDuration + avatarWaitingDuration + 200.ms;
    final namePlayDuration = 800.ms;
    final settingPlayDuration = 400.ms;
    final settingDelayDuration = nameDelayDuration;
    final userAchievementsDelayDuration = nameDelayDuration + 200.ms;
    final userAchievementsPlayDuration = 400.ms;
    final categoryPlayAnimation = userAchievementsPlayDuration;
    final categoryDelayAnimation = userAchievementsDelayDuration + 200.ms;

    final Map<String, List<Map<String, String>>> categories =
        UiUtils.isArabic(context) ? categoriesAR : categoriesEN;

    return Scaffold(
      body: BlocConsumer<UserDetailsCubit, UserDetailsState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is UserDetailsFetchInProgress ||
                state is UserDetailsIntitial) {
              return const Center(
                child: CircularProgressContainer(),
              );
            }
            if (state is UserDetailsFetchFailure) {
              return Center(
                child: ErrorContainer(
                  showBackButton: true,
                  errorMessage: state.errorMessage,
                  onTapRetry: fetchUserDetails,
                  showErrorImage: true,
                ),
              );
            }
            final userProfile = (state as UserDetailsFetchSuccess).userProfile;
            return Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
              child: CustomScrollView(
                physics: const ClampingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 5),
                        AnimatedAppBarWidget(
                          avatarWaitingDuration: avatarWaitingDuration,
                          avatarPlayDuration: avatarPlayDuration,
                          nameDelayDuration: nameDelayDuration,
                          namePlayDuration: namePlayDuration,
                          settingDelayDuration: settingDelayDuration,
                          settingPlayDuration: settingPlayDuration,
                        ),
                        UserAchievements(
                          userCoins: userProfile.coins ?? "null",
                          userRank: userProfile.allTimeRank ?? "null",
                          userAchievementDelayDuration:
                              userAchievementsDelayDuration,
                          userAchievementPlayDuration:
                              userAchievementsPlayDuration,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ...categories.keys.map((e) {
                          print(
                              "category delay is $categoryDelayAnimation ------------");
                          // categoryDelayAnimation += 200.ms ;
                          return CategoryCards(
                            content: categories[e]!,
                            categoryName: e,
                            categoryDelayAnimation: categoryDelayAnimation +
                                (200 * categories.keys.toList().indexOf(e)).ms,
                            categoryPlayAnimation: categoryPlayAnimation,
                          );
                        }).toList()
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
