// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProfileManagementException implements Exception {
  final String errorMessageCode;
  ProfileManagementException({
    required this.errorMessageCode,
  });

  @override
  String toString() => errorMessageCode;
}
