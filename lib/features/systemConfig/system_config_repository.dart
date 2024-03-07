import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:quiz_app_with_eman/features/systemConfig/system_config_exception.dart';

import '../../utils/constants/error_message_keys.dart';

class SystemConfigRepository {
  static final SystemConfigRepository _systemConfigRepository =
      SystemConfigRepository._internal();
  // late SystemConfigRemoteDataSource _systemConfigRemoteDataSource;

  factory SystemConfigRepository() {
    // _systemConfigRepository._systemConfigRemoteDataSource =
    //     SystemConfigRemoteDataSource();
    return _systemConfigRepository;
  }

  SystemConfigRepository._internal();

  // Future<SystemConfigModel> getSystemConfig() async {
  //   try {
  //     final result = await _systemConfigRemoteDataSource.getSystemConfig();
  //     return SystemConfigModel.
  //   } catch (e) {

  //   }
  // }

  Future<List<String>> getImagesFromFile(String fileName) async {
    try {
      final result = await rootBundle.loadString(fileName);
      final images = (jsonDecode(result) as Map)['images'] as List;
      return images.map((e) => e.toString()).toList();
    } catch (e) {
      throw SystemConfigException(errorMessageCode: errorCodeDefaultMessage);
    }
  }
}
