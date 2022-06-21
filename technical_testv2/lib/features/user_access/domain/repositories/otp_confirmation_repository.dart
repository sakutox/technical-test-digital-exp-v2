import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:technical_testv2/features/user_access/display/providers/user_access_provider.dart';
import '../entities/user_entitites.dart';

abstract class OtpConfirmationRepository {
  Future<Either<UserCredential, Map<String, dynamic>>> otpConfirmation(
      String phoneNumber, String otpSms, UserAccessProvider userAccessProvider);
}
