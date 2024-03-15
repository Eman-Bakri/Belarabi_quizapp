import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app_with_eman/features/settings/settings_model.dart';
import 'package:quiz_app_with_eman/features/settings/settings_repository.dart';

class SettingState {
  final SettingsModel? settingsModel;

  SettingState({this.settingsModel});
}

class SettingsCubit extends Cubit<SettingState> {
  final SettingsRepository _settingsRepository;

  SettingsCubit(this._settingsRepository) : super(SettingState()) {
    _getCurrentSettings();
  }

  void _getCurrentSettings() {
    emit(SettingState(
        settingsModel:
            SettingsModel.fromJson(_settingsRepository.getCurrentSettings())));
  }

  SettingsModel getSettings() {
    return state.settingsModel!;
  }

  void changeLanguage(String code, BuildContext context) {
    _settingsRepository.changeLanguageCode(code, context);
    emit(
      SettingState(
        settingsModel: state.settingsModel!.copyWith(languageCode: code),
      ),
    );
  }

  void changeShowIntroSlider() {
    _settingsRepository.changeIntroSlider(false);
    emit(
      SettingState(
        settingsModel: state.settingsModel!.copyWith(showIntroSlider: false),
      ),
    );
  }
}
