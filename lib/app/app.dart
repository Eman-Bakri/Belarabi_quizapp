import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quiz_app_with_eman/app/routes.dart';
import 'package:quiz_app_with_eman/features/profile_managment/cubits/user_details_cubit.dart';
import 'package:quiz_app_with_eman/features/profile_managment/profile_managment_profile.dart';
import 'package:quiz_app_with_eman/features/settings/settings_cubit.dart';
import 'package:quiz_app_with_eman/features/settings/settings_repository.dart';
import 'package:quiz_app_with_eman/features/systemConfig/cubits/system_config_cubit.dart';
import 'package:quiz_app_with_eman/features/systemConfig/system_config_repository.dart';
import 'package:quiz_app_with_eman/utils/constants/constants.dart';

import '../features/settings/settings_local_data_source.dart';
import '../ui/styles/theme/app_theme.dart';
import '../ui/styles/theme/theme_cubit.dart';

Future<Widget> intializeApp() async {
  //initilize Package before running material app

  await Hive.initFlutter();
  await Hive.openBox(settingBox);
  await Hive.openBox(userDetailsBox);

  return const MyApp();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => ThemeCubit(
              SettingsLocalDataSource(),
            ),
          ),
          BlocProvider(
            create: (_) => SystemConfigCubit(
              SystemConfigRepository(),
            ),
          ),
          BlocProvider(
            create: (_) => SettingsCubit(
              SettingsRepository(),
            ),
          ),
          BlocProvider(
            create: (_) => UserDetailsCubit(
              ProfileManagmentRepository(),
            ),
          ),
        ],
        child: Builder(builder: (context) {
          final currentTheme = context.watch<ThemeCubit>().state.appTheme;
          return AnnotatedRegion(
            value: currentTheme == AppTheme.light
                ? SystemUiOverlayStyle.dark
                : SystemUiOverlayStyle.light,
            child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              builder: (_, widget) {
                return ScrollConfiguration(
                  behavior: const _GlobalScrollBehavior(),
                  child: widget!,
                );
              },
              theme: appThemeData[currentTheme],
              locale: Locale('ar'),
              routerConfig: Routes().getRouter,
            ),
          );
        }));
  }
}

class _GlobalScrollBehavior extends ScrollBehavior {
  const _GlobalScrollBehavior();

  @override
  ScrollPhysics getScrollPhysics(_) => const BouncingScrollPhysics();
}
