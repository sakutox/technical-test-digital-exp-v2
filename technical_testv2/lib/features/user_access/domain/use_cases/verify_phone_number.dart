import 'package:technical_testv2/features/user_access/display/providers/user_access_provider.dart';
import 'package:technical_testv2/features/user_access/domain/repositories/verify_phone_repository.dart';

class VerifyPhoneNumber {
  VerifyPhoneNumberRepository verifyPhoneNumberRepository;

  VerifyPhoneNumber({required this.verifyPhoneNumberRepository});

  Future<Map<String, dynamic>> call(
      String phoneNumber, UserAccessProvider userAccessProvider) async {
    return verifyPhoneNumberRepository.verifyPhoneNumber(phoneNumber, userAccessProvider);
  }
}
