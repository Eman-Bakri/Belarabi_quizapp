import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app_with_eman/app/routes.dart';
import 'package:quiz_app_with_eman/features/profile_managment/cubits/user_details_cubit.dart';
import 'package:quiz_app_with_eman/features/profile_managment/models/user_profile.dart';
import 'package:quiz_app_with_eman/features/settings/settings_cubit.dart';
import 'package:quiz_app_with_eman/ui/widgets/profile/error_container.dart';

import '../../features/systemConfig/cubits/system_config_cubit.dart';
import '../../utils/ui_utils.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  String? selectedAvatar;
  TextEditingController? nameController;
  late final AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<UserDetailsCubit>().fetchUserDetails();
    _animationController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    if (nameController != null) nameController!.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<UserDetailsCubit, UserDetailsState>(
        builder: (context, state) {
          if (state is UserDetailsFetchInProgress ||
              state is UserDetailsIntitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is UserDetailsFetchFailure) {
            return ErrorContainer(
              errorMessage: state.errorMessage,
              onTapRetry: () {
                context.read<UserDetailsCubit>().fetchUserDetails();
              },
              showErrorImage: true,
            );
          }
          UserProfile userProfile =
              (state as UserDetailsFetchSuccess).userProfile;
          nameController ??= TextEditingController(text: userProfile.name);
          selectedAvatar ??= userProfile.profileAvatar;

          final size = MediaQuery.of(context).size;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  // height: size.height * .025,
                  height: size.height * .15,
                ),
                Center(
                  child: _buildCurrentProfilePictureContainer(
                      image: selectedAvatar ?? ""),
                ),
                const SizedBox(height: 15.0),
                Center(
                  child: Text(
                    "Select Avatar",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onTertiary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * .04,
                  ),
                  child: _buildDefaultAvtarImages(),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Divider(color: Colors.blueGrey[200]),
                ),
                SizedBox(
                  height: size.height * .02,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * .04),
                  child: _buildNameTextFieldContainer(),
                ),
                SizedBox(
                  height: size.height * .05,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * .04),
                  child: _buildContinueButton(_animationController),
                ),
                SizedBox(
                  height: 50,
                )
              ],
            )
                .animate(
                  autoPlay: false,
                  controller: _animationController,
                )
                .blurXY(
                    begin: 0,
                    end: 25,
                    duration: 600.ms,
                    curve: Curves.easeInOut)
                .scaleXY(begin: 1, end: 0.6)
                .fadeOut(begin: 1),
          );
        },
        listener: ((context, state) {}),
      ),
    );
  }

  Widget _buildCurrentProfilePictureContainer({
    required String image,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final width = MediaQuery.of(context).size.width;
    if (image.isEmpty) {
      return Container(
        width: width * 0.3,
        height: width * 0.3,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Icon(Icons.account_circle_outlined),
        ),
      );
    }
    return SizedBox(
      width: width * (0.3),
      height: width * (0.3),
      child: LayoutBuilder(
        builder: (_, constraints) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: width * (0.3),
                  height: width * (0.3),
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    border: Border.all(color: colorScheme.background),
                    shape: BoxShape.circle,
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(width * .15),
                      child: Image.asset(
                        UiUtils.getProfileImagePath(image),
                      )),
                ),
              ),
            ],
          );
        },
      ),
    )
        .animate(onPlay: (controller) => controller.repeat())
        .shimmer(delay: 1000.ms, duration: 1800.ms);
  }

  Widget _buildDefaultAvtarImages() {
    final defaultProfileImages =
        (context.read<SystemConfigCubit>().state as SystemConfigFetchSuccess)
            .defaultProfileImages;

    return SizedBox(
      height: MediaQuery.of(context).size.height * (0.23),
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: defaultProfileImages.length,
        itemBuilder: (_, i) => _buildDefaultAvtarImage(
          i,
          defaultProfileImages[i],
        ),
      ),
    );
  }

  Widget _buildDefaultAvtarImage(int index, String imageName) {
    return GestureDetector(
      onTap: () => setState(() {
        selectedAvatar = imageName;
      }),
      child: LayoutBuilder(
        builder: (_, constraints) {
          final size = constraints.maxHeight * .66;

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 7),
            height: size,
            width: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(
                  UiUtils.getProfileImagePath(imageName),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNameTextFieldContainer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Profile Name",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onTertiary,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Theme.of(context).colorScheme.background,
          ),
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: TextFormField(
            validator: (_) => null,
            controller: nameController,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onTertiary,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            decoration: InputDecoration(
              hintText: "Enter your Name",
              border: InputBorder.none,
              hintStyle: TextStyle(
                  color:
                      Theme.of(context).colorScheme.onTertiary.withOpacity(.4)),
              contentPadding: const EdgeInsets.only(left: 10),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildContinueButton(AnimationController controller) {
    return TextButton(
      style: TextButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
      onPressed: () {
        if (selectedAvatar == null) {
          UiUtils.setSnackBar("Select your Avatar", context, false);
          return;
        }
        if (nameController!.text.isEmpty) {
          UiUtils.setSnackBar("Enter your name", context, false);
          return;
        }
        context.read<UserDetailsCubit>().updateUserProfile(
              name: nameController!.text,
              profileAvatar: selectedAvatar,
            );
        context.read<SettingsCubit>().changeShowIntroSlider();
        controller.forward();
        controller.addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            Future.delayed(400.ms, () {
              context.go(PageName.homeRoute);
            });
          }
        });
      },
      child: Text(
        "Continue",
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .merge(TextStyle(color: Theme.of(context).colorScheme.background)),
      ),
    );
  }
}
