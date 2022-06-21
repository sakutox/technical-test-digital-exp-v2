import 'package:firebase_auth/firebase_auth.dart';
import 'package:technical_testv2/features/user_access/display/providers/user_access_provider.dart';
import 'package:dartz/dartz.dart';
import '../repositories/otp_confirmation_repository.dart';

class OtpConfirmation {
  OtpConfirmationRepository otpConfirmationRepository;

  OtpConfirmation({required this.otpConfirmationRepository});

  Future<Either<UserCredential, Map<String, dynamic>>> call(
      String phoneNumber, UserAccessProvider userAccessProvider,  String otpSms,) async {
    return otpConfirmationRepository.otpConfirmation(phoneNumber, otpSms, userAccessProvider);
  }
}
