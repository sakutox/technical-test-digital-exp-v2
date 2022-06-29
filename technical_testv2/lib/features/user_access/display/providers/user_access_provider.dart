import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:technical_testv2/features/user_access/data/datasources/remote_datasource.dart';
import 'package:technical_testv2/features/user_access/data/models/user_model.dart';
import 'package:technical_testv2/features/user_access/data/repositories/create_user_repository_impl.dart';
import 'package:technical_testv2/features/user_access/data/repositories/otp_confirmation_repository_impl.dart';
import 'package:technical_testv2/features/user_access/data/repositories/verify_phone_number_repository_impl.dart';
import 'package:technical_testv2/features/user_access/domain/use_cases/create_user.dart';
import 'package:technical_testv2/features/user_access/domain/use_cases/otp_confirmation.dart';
import 'package:technical_testv2/features/user_access/domain/use_cases/verify_phone_number.dart';

class UserAccessProvider with ChangeNotifier {
  bool verifyPhoneChecker = false;
  String otpCode = '';
  String verificationId = '';
  String userUid = '';
  bool codeSent = false;
  bool errorChecker = false;

  Future<Map<String, dynamic>> verifyPhoneNumberProviderFunction(
      {required String phoneNumber,
      required UserAccessProvider userAccessProvider,
      required BuildContext context}) async {
    VerifyPhoneNumberRepositoryImpl repository =
        VerifyPhoneNumberRepositoryImpl(RemoteDataSourceImpl());

    final verifyPhoneNumber =
        await VerifyPhoneNumber(verifyPhoneNumberRepository: repository)
            .call(phoneNumber, userAccessProvider);

    if (verifyPhoneNumber['status'] == 'success') {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushNamed('/otp_screen', arguments: phoneNumber);
      return verifyPhoneNumber;
    } else {
      Fluttertoast.showToast(msg: '$verifyPhoneNumber');
      return verifyPhoneNumber;
    }
  }

  codeSentVerification() {
    codeSent = true;
    notifyListeners();
  }

  Future<bool> createUser(String name, String email, String phone, String uid,
      BuildContext context) async {
    CreateUserInfoRepositoryImpl repository =
        CreateUserInfoRepositoryImpl(RemoteDataSourceImpl());

    bool userCreation = false;

    try {
      UserModel user =
          UserModel(email: email, name: name, phone: phone, uid: uid);

      final userCreated =
          await CreateUserInfo(createUserRepository: repository).call(user);

      if (userCreated is UserModel) {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacementNamed('/map_screen_clean_arq');
        return userCreation = true;
      } else {
        return userCreation;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'error on create user provider: $e');
      return userCreation;
    }
  }

  Future<void> verifyOtpManually(
      String verificationId,
      String phoneNumber,
      String smsCode,
      UserAccessProvider userAccessProvider,
      BuildContext context) async {
    bool otpConfirmationReturn = false;
    bool errorCatch = false;

    try {
      OtpConfirmationRepositoryImpl repository =
          OtpConfirmationRepositoryImpl(RemoteDataSourceImpl());

      final otpConfirmation =
          await OtpConfirmation(otpConfirmationRepository: repository)
              .call(phoneNumber, userAccessProvider, smsCode, verificationId);

      otpConfirmationReturn = otpConfirmation;
    } catch (e) {
      log('$e');
      Fluttertoast.showToast(msg: '$e');
      errorCatch = true;
    }

    if (otpConfirmationReturn && errorCatch == false) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacementNamed('/map_screen_clean_arq');
    } else if (userAccessProvider.errorChecker == false) {
      // ignore: use_build_context_synchronously
      Navigator.of(context)
          .pushReplacementNamed('/register_screen', arguments: phoneNumber);
    }
  }
}
