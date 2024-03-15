// ignore_for_file: public_member_api_docs, sort_constructors_first
class SettingsModel {
  final bool showIntroSlider;
  final String languageCode;

  SettingsModel({
    required this.showIntroSlider,
    required this.languageCode,
  });

  static SettingsModel fromJson(Map<String, dynamic> settingsJson) {
    return SettingsModel(
        showIntroSlider: settingsJson["showIntroSlider"],
        languageCode: settingsJson["languageCode"]);
  }

  SettingsModel copyWith({
    bool? showIntroSlider,
    String? languageCode,
  }) {
    return SettingsModel(
      showIntroSlider: showIntroSlider ?? this.showIntroSlider,
      languageCode: languageCode ?? this.languageCode,
    );
  }
}
