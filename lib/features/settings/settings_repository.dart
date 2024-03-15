import 'package:flutter/material.dart';

import 'settings_local_data_source.dart';

class SettingsRepository {
  static final SettingsRepository _settingsRepository =
      SettingsRepository._internal();

  late SettingsLocalDataSource _settingsLocalDataSource;

  SettingsRepository._internal();

  factory SettingsRepository() {
    _settingsRepository._settingsLocalDataSource = SettingsLocalDataSource();
    return _settingsRepository;
  }

  Map<String, dynamic> getCurrentSettings() {
    return {
      "showIntroSlider": _settingsLocalDataSource.showIntroSlider(),
      "languageCode": _settingsLocalDataSource.getLangugeCode(),
    };
  }

  void changeLanguageCode(String value, BuildContext context) =>
      _settingsLocalDataSource.setLangugeCode(value, context);

  void changeIntroSlider(bool value) =>
      _settingsLocalDataSource.setShowSlider(value);
}
