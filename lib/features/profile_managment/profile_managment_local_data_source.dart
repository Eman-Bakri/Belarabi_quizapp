import 'package:hive_flutter/hive_flutter.dart';
import 'package:quiz_app_with_eman/utils/constants/constants.dart';

class ProfileManagementLocalDataSource {
  String getName() {
    return Hive.box(userDetailsBox).get(nameBoxKey, defaultValue: "");
  }

  String getCoins() {
    return Hive.box(userDetailsBox).get(coinsBoxKey, defaultValue: "");
  }

  String getProfileAvatar() {
    return Hive.box(userDetailsBox).get(profileAvatarBoxKey, defaultValue: "");
  }

  Future<void> setName(String name) async {
    Hive.box(userDetailsBox).put(nameBoxKey, name);
  }

  Future<void> setCoins(String coins) async {
    Hive.box(userDetailsBox).put(coinsBoxKey, coins);
  }

  Future<void> setProfileAvatar(String profileAvatar) async {
    Hive.box(userDetailsBox).put(profileAvatarBoxKey, profileAvatar);
  }
}
