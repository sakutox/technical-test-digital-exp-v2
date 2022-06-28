import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:technical_testv2/core/firebase_config/firebase_initialize_app.dart';
import 'package:technical_testv2/features/user_access/display/providers/user_access_provider.dart';
import '../models/user_model.dart';

abstract class RemoteDataSource {
  Future<bool> createUser(UserModel user);
  Future<void> verifyPhoneNumber(
      String phoneNumber, UserAccessProvider userAccessProvider);
  Future<bool> verifyPhoneNumberManualValidation(
      String verificationId,
      String smsCode,
      String phoneNumber,
      UserAccessProvider userAccessProvider);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  
  @override
  Future<bool> createUser(UserModel user) async {
    bool status = false;
    try {
      Map<String, dynamic> map = user.toMap();

      // ignore: unused_local_variable
      final response =
          FirebaseConfig.db.collection('users').doc(user.uid).set(map);
      return status = true;
    } catch (e) {
      log('$e');
      return status;
    }
  }

  @override
  Future<void> verifyPhoneNumber(
      String phoneNumber, UserAccessProvider userAccessProvider) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+57$phoneNumber',
      verificationCompleted: (PhoneAuthCredential credential) async {
        try {
          UserCredential userCredential =
              await FirebaseConfig.auth.signInWithCredential(credential);

          userAccessProvider.verifyPhoneChecker = await userCreatedVerification(
              userCredential, phoneNumber, userAccessProvider);
        } catch (e) {
          log('$e');
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {}
      },
      codeSent: (String verificationId, int? resendToken) async {
        userAccessProvider.verificationId = verificationId;
        // print('verificationID: ${userAccessProvider.verificationId}');
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  @override
  Future<bool> verifyPhoneNumberManualValidation(
      String verificationId,
      String smsCode,
      String phoneNumber,
      UserAccessProvider userAccessProvider) async {
    bool statusForProviderConfirmation = false;

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);

    try {
      UserCredential userCredential =
          await FirebaseConfig.auth.signInWithCredential(credential);

      // ignore: use_build_context_synchronously
      statusForProviderConfirmation = await userCreatedVerification(
          userCredential, phoneNumber, userAccessProvider);
    } catch (e) {
      log('error on remote datasource verify number function: $e');
    }

    return statusForProviderConfirmation;
  }

  Future<bool> userCreatedVerification(UserCredential userCredential,
      String phoneNumber, UserAccessProvider userAccessProvider) async {
    bool userCreatedStatus = false;

    if (userCredential.user != null) {
      DocumentSnapshot snapshot = await FirebaseConfig.db
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      userAccessProvider.userUid = userCredential.user!.uid;

      if (snapshot.exists) {
        userCreatedStatus = true;
      }
    }
    return userCreatedStatus;
  }
}
