// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/supported_languages.dart';
import '../model/system_config_model.dart';
import '../system_config_repository.dart';

abstract class SystemConfigState {}

class SystemConfigInitial extends SystemConfigState {}

class SystemConfigFetchInProgress extends SystemConfigState {}

class SystemConfigFetchSuccess extends SystemConfigState {
  final SystemConfigModel systemConfigModel;
  final List<SupportedLanguages> supportedLanguages;
  final List<String> emojis;
  final List<String> defaultProfileImages;
  SystemConfigFetchSuccess({
    required this.systemConfigModel,
    required this.supportedLanguages,
    required this.emojis,
    required this.defaultProfileImages,
  });
}

class SystemConfigFetchFailure extends SystemConfigState {
  final String errorCode;
  SystemConfigFetchFailure({
    required this.errorCode,
  });
}

class SystemConfigCubit extends Cubit<SystemConfigState> {
  final SystemConfigRepository _systemConfigRepository;

  SystemConfigCubit(this._systemConfigRepository)
      : super(SystemConfigInitial());

  void getSystemConfig() async {
    emit(SystemConfigFetchInProgress());
    try {
      List<SupportedLanguages> supportedLanguages = [];
      //check netowrk
      await InternetAddress.lookup('example.com');

      final emojis = await _systemConfigRepository
          .getImagesFromFile("assets/files/emojis.json");
      final defaultProfilImages = await _systemConfigRepository
          .getImagesFromFile("assets/files/defaultProfileImages.json");

      // await Future.delayed(Duration(seconds: 3));
      emit(
        SystemConfigFetchSuccess(
          systemConfigModel: SystemConfigModel(),
          supportedLanguages: supportedLanguages,
          emojis: emojis,
          defaultProfileImages: defaultProfilImages,
        ),
      );
    } catch (e) {
      print(e);
      emit(SystemConfigFetchFailure(errorCode: e.toString()));
    }
  }
}
