import 'package:provider/provider.dart';
import 'package:dartz/dartz.dart';
import 'package:technical_testv2/features/create_user/display/providers/create_user_provider.dart';
import 'package:technical_testv2/features/create_user/domain/repositories/verify_phone_repository.dart';
import 'package:technical_testv2/features/create_user/domain/use_cases/create_user.dart';
import '../../domain/entities/user_entitites.dart';
import '../datasources/remote_datasource.dart';

class VerifyPhoneNumberRepositoryImpl implements VerifyPhoneNumberRepository {
  RemoteDataSource dataSource;
  VerifyPhoneNumberRepositoryImpl(this.dataSource);

  @override
  Future<Map<String, dynamic>> verifyPhoneNumber(
      String phoneNumber, CreateUserProvider provider) async {
    try {
      await dataSource.verifyPhoneNumber(phoneNumber, provider);
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
