import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quiz_app_with_eman/utils/constants/constants.dart';

import '../../utils/constants/string_labels.dart';

class SettingsLocalDataSource {
  String getLangugeCode() {
    return Hive.box(settingBox).get(languageCodeKey, defaultValue: 'en');
  }

  Future<void> setLangugeCode(String value, BuildContext context) {
    context.setLocale(Locale(value));
    return Hive.box(settingBox).put(languageCodeKey, value);
  }

  String theme() {
    return Hive.box(settingBox).get(
      settingThemeKey,
      defaultValue: lightThemeKey,
    );
  }

  Future<void> setTheme(String value) async {
    Hive.box(settingBox).put(settingThemeKey, value);
  }

  bool? showIntroSlider() {
    return Hive.box(settingBox).get(showIntroSliderKey, defaultValue: true);
  }

  Future<void> setShowSlider(bool value) async {
    Hive.box(settingBox).put(showIntroSliderKey, value);
  }
}
