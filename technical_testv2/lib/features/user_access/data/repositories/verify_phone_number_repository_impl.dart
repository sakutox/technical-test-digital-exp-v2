import 'dart:developer';
import 'package:technical_testv2/features/user_access/display/providers/user_access_provider.dart';
import 'package:technical_testv2/features/user_access/domain/repositories/verify_phone_repository.dart';
import '../datasources/remote_datasource.dart';

class VerifyPhoneNumberRepositoryImpl implements VerifyPhoneNumberRepository {
  RemoteDataSource dataSource;
  VerifyPhoneNumberRepositoryImpl(this.dataSource);

  @override
  Future<Map<String, dynamic>> verifyPhoneNumber(
      String phoneNumber, UserAccessProvider userAccessProvider) async {
    try {
      await dataSource.verifyPhoneNumber(phoneNumber, userAccessProvider);
      log('aca entró');
      return {
        "status": "success",
        "message": "all g",
      };
    } catch (e) {
      return {
        "status": "fail",
        "message": "$e",
      };
    }
  }
}
