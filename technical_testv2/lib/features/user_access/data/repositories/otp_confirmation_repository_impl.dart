import 'package:technical_testv2/features/user_access/display/providers/user_access_provider.dart';
import 'package:technical_testv2/features/user_access/domain/repositories/otp_confirmation_repository.dart';

import '../datasources/remote_datasource.dart';

class OtpConfirmationRepositoryImpl implements OtpConfirmationRepository {
  RemoteDataSource dataSource;
  OtpConfirmationRepositoryImpl(this.dataSource);

  @override
  Future<bool> otpConfirmation(String phoneNumber, String smsCode,
      UserAccessProvider userAccessProvider, String verificationId) async {
    bool result = await dataSource.verifyPhoneNumberManualValidation(
        verificationId, smsCode, phoneNumber, userAccessProvider);

    return result;
  }
}
