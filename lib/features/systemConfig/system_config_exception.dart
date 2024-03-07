// ignore_for_file: public_member_api_docs, sort_constructors_first
class SystemConfigException implements Exception {
  final String errorMessageCode;
  SystemConfigException({
    required this.errorMessageCode,
  });

  @override
  String toString() => errorMessageCode;
}
