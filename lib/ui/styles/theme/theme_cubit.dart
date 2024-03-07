import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app_with_eman/features/settings/settings_local_data_source.dart';
import 'package:quiz_app_with_eman/utils/constants/string_labels.dart';

import 'app_theme.dart';

class ThemeState {
  final AppTheme appTheme;

  const ThemeState(this.appTheme);
}

class ThemeCubit extends Cubit<ThemeState> {
  SettingsLocalDataSource settingsLocalDataSource;

  ThemeCubit(this.settingsLocalDataSource)
      : super(
          ThemeState(
            settingsLocalDataSource.theme() == darkThemeKey
                ? AppTheme.dark
                : AppTheme.light,
          ),
        );
  void changeTheme(AppTheme appTheme) {
    settingsLocalDataSource.setTheme(
      appTheme == AppTheme.dark ? darkThemeKey : lightThemeKey,
    );
    emit(ThemeState(appTheme));
  }
}
