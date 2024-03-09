import 'package:quiz_app_with_eman/features/profile_managment/models/user_profile.dart';
import 'package:quiz_app_with_eman/features/profile_managment/profile_managment_exception.dart';
import 'package:quiz_app_with_eman/utils/constants/error_message_keys.dart';

import 'profile_managment_local_data_source.dart';

class ProfileManagmentRepository {
  static final ProfileManagmentRepository _profileManagmentRepository =
      ProfileManagmentRepository._internal();
  late ProfileManagementLocalDataSource _profileManagementLocalDataSource;
  // late ProfileManagementRemoteDataSoruce _profileManagementRemoteDataSoruce;

  factory ProfileManagmentRepository() {
    _profileManagmentRepository._profileManagementLocalDataSource =
        ProfileManagementLocalDataSource();
    // _profileManagmentRepository._profileManagementRemoteDataSoruce =
    //     ProfileManagementRemoteDataSoruce();
    return _profileManagmentRepository;
  }

  ProfileManagmentRepository._internal();

  ProfileManagementLocalDataSource get profileManagementLocalDataSource =>
      _profileManagementLocalDataSource;

  Future<void> setUserDetailsLocally(UserProfile userProfile) async {
    await profileManagementLocalDataSource.setName(userProfile.name!);
    await profileManagementLocalDataSource.setCoins(userProfile.coins!);
    await profileManagementLocalDataSource
        .setAllTimeRank(userProfile.allTimeRank!);
    await profileManagementLocalDataSource
        .setProfileAvatar(userProfile.profileAvatar!);
  }

  Future<UserProfile> getUserDetails() async {
    try {
      final user = UserProfile(
        name: _profileManagementLocalDataSource.getName(),
        coins: _profileManagementLocalDataSource.getCoins(),
        profileAvatar: _profileManagementLocalDataSource.getProfileAvatar(),
        allTimeRank: _profileManagementLocalDataSource.getAllTimeRank(),
      );
      print(user);
      return user;
    } catch (e) {
      print("error: $e");
      throw ProfileManagementException(
          errorMessageCode: errorCodeDefaultMessage);
    }
  }
}
