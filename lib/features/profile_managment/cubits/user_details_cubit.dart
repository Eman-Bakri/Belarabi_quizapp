// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app_with_eman/features/profile_managment/profile_managment_profile.dart';

import '../models/user_profile.dart';

@immutable
abstract class UserDetailsState {}

class UserDetailsIntitial extends UserDetailsState {}

class UserDetailsFetchInProgress extends UserDetailsState {}

class UserDetailsFetchSuccess extends UserDetailsState {
  final UserProfile userProfile;
  UserDetailsFetchSuccess({
    required this.userProfile,
  });
}

class UserDetailsFetchFailure extends UserDetailsState {
  final String errorMessage;
  UserDetailsFetchFailure({
    required this.errorMessage,
  });
}

class UserDetailsCubit extends Cubit<UserDetailsState> {
  final ProfileManagmentRepository _profileManagmentRepository;

  UserDetailsCubit(
    this._profileManagmentRepository,
  ) : super(UserDetailsIntitial());

  void fetchUserDetails() async {
    emit(UserDetailsFetchInProgress());
    try {
      print("emit cirecule view");
      UserProfile userProfile =
          await _profileManagmentRepository.getUserDetails();
      print(userProfile);
      Future.delayed(Duration(seconds: 3));
      emit(UserDetailsFetchSuccess(userProfile: userProfile));
    } catch (e) {
      emit(UserDetailsFetchFailure(errorMessage: e.toString()));
    }
  }

  void updateUserProfile({
    String? name,
    String? profileAvatar,
    String? coins,
    String? allTimeRank,
  }) {
    if (state is UserDetailsFetchSuccess) {
      final oldUserDetails = (state as UserDetailsFetchSuccess).userProfile;
      final userDetails = oldUserDetails.copyWith(
        name: name,
        profileAvatar: profileAvatar,
        coins: coins,
        allTimeRank: allTimeRank,
      );
      _profileManagmentRepository.setUserDetailsLocally(userDetails);
      emit(UserDetailsFetchSuccess(userProfile: userDetails));
    }
  }
}
