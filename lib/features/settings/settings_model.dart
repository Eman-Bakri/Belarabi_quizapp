// ignore_for_file: public_member_api_docs, sort_constructors_first
class SettingsModel {
  final bool showIntroSlider;

  SettingsModel({required this.showIntroSlider});

  static SettingsModel fromJson(Map<String, dynamic> settingsJson) {
    return SettingsModel(showIntroSlider: settingsJson["showIntroSlider"]);
  }

  SettingsModel copyWith({
    bool? showIntroSlider,
  }) {
    return SettingsModel(
      showIntroSlider: showIntroSlider ?? this.showIntroSlider,
    );
  }
}
