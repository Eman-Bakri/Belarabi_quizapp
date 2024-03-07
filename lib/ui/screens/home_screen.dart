import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app_with_eman/features/profile_managment/cubits/user_details_cubit.dart';
import 'package:quiz_app_with_eman/ui/widgets/home/animated_appbar_widget.dart';

import '../widgets/home/circular_progress_container.dart';

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
    context.read<UserDetailsCubit>().fetchUserDetails();
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
            return CustomScrollView(
              physics: const ClampingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 60),
                      AnimatedAppBarWidget(
                        avatarWaitingDuration: avatarWaitingDuration,
                        avatarPlayDuration: avatarPlayDuration,
                        nameDelayDuration: nameDelayDuration,
                        namePlayDuration: namePlayDuration,
                        settingDelayDuration: settingDelayDuration,
                        settingPlayDuration: settingPlayDuration,
                      )
                    ],
                  ),
                )
              ],
            );
          }),
    );
  }
}
