import 'package:technical_testv2/features/user_access/display/providers/user_access_provider.dart';

abstract class OtpConfirmationRepository {
  Future<bool> otpConfirmation(String phoneNumber, String otpSms,
      UserAccessProvider userAccessProvider, String verificationId);
}
