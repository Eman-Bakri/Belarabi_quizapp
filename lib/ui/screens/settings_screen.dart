import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/constants/fonts.dart';
import '../../utils/ui_utils.dart';
import '../styles/theme/app_theme.dart';
import '../styles/theme/theme_cubit.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyle(color: Theme.of(context).colorScheme.onTertiary),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () => setState(() => _showThemeSelector()),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.background,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      UiUtils.getImagePath('theme_icon.svg'),
                      color: Theme.of(context).primaryColor,
                      width: 25,
                      height: 25,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      "Theme",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Theme.of(context).colorScheme.onTertiary,
                        fontWeight: FontWeights.regular,
                      ),
                      maxLines: 1,
                    ),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () => setState(() => _showLanguageSelector()),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.background,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      UiUtils.getImagePath('language_icon.svg'),
                      color: Theme.of(context).primaryColor,
                      width: 25,
                      height: 25,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      "Language",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Theme.of(context).colorScheme.onTertiary,
                        fontWeight: FontWeights.regular,
                      ),
                      maxLines: 1,
                    ),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showThemeSelector() {
    final size = MediaQuery.of(context).size;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: UiUtils.bottomSheetTopRadius,
      ),
      builder: (_) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: UiUtils.bottomSheetTopRadius,
          ),
          height: size.height * 0.5,
          padding: EdgeInsets.only(
            top: size.height * .02,
          ),
          child: BlocBuilder<ThemeCubit, ThemeState>(
            bloc: context.read<ThemeCubit>(),
            builder: (context, state) {
              AppTheme? currTheme = state.appTheme;
              final colorScheme = Theme.of(context).colorScheme;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Theme",
                      style: TextStyle(
                        fontWeight: FontWeights.bold,
                        fontSize: 18,
                        color: colorScheme.onTertiary,
                      ),
                    ),
                  ),
                  // horizontal divider
                  Divider(
                    color: colorScheme.onTertiary.withOpacity(0.2),
                    thickness: 1,
                  ),
                  SizedBox(height: size.height * 0.02),
                  Container(
                    decoration: BoxDecoration(
                      color: currTheme == AppTheme.light
                          ? Theme.of(context).primaryColor
                          : colorScheme.onTertiary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.symmetric(
                      horizontal: size.width * 0.04,
                    ),
                    child: RadioListTile<AppTheme>(
                      toggleable: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      tileColor: colorScheme.onTertiary.withOpacity(0.2),
                      value: AppTheme.light,
                      groupValue: currTheme,
                      activeColor: Colors.white,
                      title: Text(
                        "Light Theme",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: currTheme == AppTheme.light
                              ? Colors.white
                              : colorScheme.onTertiary,
                        ),
                      ),
                      secondary: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: currTheme == AppTheme.light
                                ? Colors.white
                                : colorScheme.onTertiary.withOpacity(0.2),
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.all(2),
                        child: SvgPicture.asset(
                          UiUtils.getImagePath("day.svg"),
                          width: 76,
                          height: 28,
                        ),
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (v) {
                        setState(() {
                          currTheme = v;
                          context.read<ThemeCubit>().changeTheme(currTheme!);
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: currTheme == AppTheme.dark
                          ? Theme.of(context).primaryColor
                          : colorScheme.onTertiary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.symmetric(
                      horizontal: size.width * 0.04,
                    ),
                    child: RadioListTile<AppTheme>(
                      toggleable: true,
                      value: AppTheme.dark,
                      groupValue: currTheme,
                      activeColor: Colors.white,
                      title: Text(
                        "Dark Theme",
                        style: TextStyle(
                          fontWeight: FontWeights.medium,
                          fontSize: 18,
                          color: currTheme == AppTheme.dark
                              ? Colors.white
                              : colorScheme.onTertiary,
                        ),
                      ),
                      secondary: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: currTheme == AppTheme.dark
                                ? Colors.white
                                : colorScheme.onTertiary.withOpacity(0.2),
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.all(2),
                        child: SvgPicture.asset(
                          UiUtils.getImagePath("night.svg"),
                          width: 76,
                          height: 28,
                        ),
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (v) {
                        setState(() {
                          currTheme = v;
                          context.read<ThemeCubit>().changeTheme(currTheme!);
                        });
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  void _showLanguageSelector() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: UiUtils.bottomSheetTopRadius,
      ),
      builder: (_) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: UiUtils.bottomSheetTopRadius,
          ),
          height: MediaQuery.of(context).size.height * .6,
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * .02,
          ),
          child: Builder(
            builder: (context) {
              final textStyle = TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Theme.of(context).colorScheme.onTertiary,
              );

              var currLang = context.locale;

              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    /// Title
                    Text(
                      "Language",
                      style: textStyle,
                    ),
                    const Divider(),

                    Container(
                      decoration: BoxDecoration(
                        color: currLang == const Locale('en')
                            ? Theme.of(context).primaryColor
                            : Theme.of(context)
                                .colorScheme
                                .onTertiary
                                .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.01,
                        horizontal: MediaQuery.of(context).size.width * 0.04,
                      ),
                      child: RadioListTile(
                        toggleable: true,
                        activeColor: Colors.white,
                        value: context.locale.languageCode,
                        title: Text(
                          "English",
                          style: textStyle.copyWith(
                            color: currLang == Locale('en')
                                ? Colors.white
                                : Theme.of(context).colorScheme.onTertiary,
                          ),
                        ),
                        groupValue: currLang,
                        onChanged: (value) {
                          context.setLocale(Locale('en'));
                          // currLang = value!;

                          // if (state.language != locale) {
                          //   context
                          //       .read<AppLocalizationCubit>()
                          //       .changeLanguage(language.languageCode);
                          // }
                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: currLang == const Locale('ar')
                            ? Theme.of(context).primaryColor
                            : Theme.of(context)
                                .colorScheme
                                .onTertiary
                                .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.01,
                        horizontal: MediaQuery.of(context).size.width * 0.04,
                      ),
                      child: RadioListTile(
                        toggleable: true,
                        activeColor: Colors.white,
                        value: context.locale.languageCode,
                        title: Text(
                          "Arabic",
                          style: textStyle.copyWith(
                            color: currLang == Locale('ar')
                                ? Colors.white
                                : Theme.of(context).colorScheme.onTertiary,
                          ),
                        ),
                        groupValue: currLang,
                        onChanged: (value) {
                          context.setLocale(Locale('ar'));
                          // currLang = value!;

                          // if (state.language != locale) {
                          //   context
                          //       .read<AppLocalizationCubit>()
                          //       .changeLanguage(language.languageCode);
                          // }
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
