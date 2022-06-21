import 'package:flutter/cupertino.dart';
import 'package:technical_testv2/features/user_access/data/datasources/remote_datasource.dart';
import 'package:technical_testv2/features/user_access/data/repositories/verify_phone_number_repository_impl.dart';
import 'package:technical_testv2/features/user_access/domain/use_cases/verify_phone_number.dart';

class UserAccessProvider with ChangeNotifier {
  bool verifyPhoneChecker = false;
  String otpCode = '';

  Future<Map<String, dynamic>> verifyPhoneNumberProviderFunction(
      {required String phoneNumber,
      required UserAccessProvider userAccessProvider}) async {
    VerifyPhoneNumberRepositoryImpl repository =
        VerifyPhoneNumberRepositoryImpl(RemoteDataSourceImpl());

    final verifyPhoneNumber =
        await VerifyPhoneNumber(verifyPhoneNumberRepository: repository)
            .call(phoneNumber, userAccessProvider);

    return verifyPhoneNumber;
  }
}
