import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:technical_testv2/features/create_user/data/datasources/remote_datasource.dart';
import 'package:technical_testv2/features/create_user/data/repositories/verify_phone_number_repository_impl.dart';
import 'package:technical_testv2/features/create_user/domain/use_cases/verify_phone_number.dart';

class CreateUserProvider with ChangeNotifier {
  bool verifyPhoneChecker = false;

  Future<Map<String, dynamic>> verifyPhoneNumberProviderFunction(
      {required String phoneNumber,
      required CreateUserProvider createUserProvider}) async {
    VerifyPhoneNumberRepositoryImpl repository =
        VerifyPhoneNumberRepositoryImpl(RemoteDataSourceImpl());

    final verifyPhoneNumber =
        await VerifyPhoneNumber(verifyPhoneNumberRepository: repository)
            .call(phoneNumber, createUserProvider);

    return verifyPhoneNumber;
  }
}
