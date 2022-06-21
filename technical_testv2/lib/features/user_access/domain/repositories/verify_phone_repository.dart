import 'package:technical_testv2/features/user_access/display/providers/user_access_provider.dart';

abstract class VerifyPhoneNumberRepository {
  Future<Map<String, dynamic>> verifyPhoneNumber(
      String phoneNumber, UserAccessProvider userAccessProvider);
}
