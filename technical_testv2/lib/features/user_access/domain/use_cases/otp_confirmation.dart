import 'package:technical_testv2/features/user_access/display/providers/user_access_provider.dart';
import '../repositories/otp_confirmation_repository.dart';

class OtpConfirmation {
  OtpConfirmationRepository otpConfirmationRepository;

  OtpConfirmation({required this.otpConfirmationRepository});

  Future<bool> call(
      String phoneNumber, UserAccessProvider userAccessProvider,  String otpSms, String verificationId) async {
    return otpConfirmationRepository.otpConfirmation(phoneNumber, otpSms, userAccessProvider, verificationId);
  }
}
