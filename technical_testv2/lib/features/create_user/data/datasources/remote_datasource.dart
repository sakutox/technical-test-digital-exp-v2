import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:technical_testv2/core/firebase_config/firebase_initialize_app.dart';
import 'package:technical_testv2/features/create_user/display/providers/create_user_provider.dart';
import '../models/user_model.dart';

abstract class RemoteDataSource {
  Future<void> createUser(UserModel user);
  Future<void> verifyPhoneNumber(
      String phoneNumber, CreateUserProvider provider);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  @override
  Future<void> createUser(UserModel user) async {
    Future<UserModel> userModel;
    try {
      final response = FirebaseConfig.db.doc(user.uid).set(user.toJson());
    } catch (e) {}
  }

  @override
  Future<void> verifyPhoneNumber(
      String phoneNumber, CreateUserProvider createUserProvider) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+57$phoneNumber',
      verificationCompleted: (PhoneAuthCredential credential) async {
        try {
          UserCredential userCredential =
              await FirebaseConfig.auth.signInWithCredential(credential);

          createUserProvider.verifyPhoneChecker =
              await userCreatedVerification(userCredential, phoneNumber);
        } catch (e) {
          log('$e');
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {}
      },
      codeSent: (String verificationId, int? resendToken) async {},
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<bool> verifyPhoneNumberManualValidation(
      String verificationId, String smsCode, String phoneNumber) async {
    bool statusForProviderConfirmation = false;
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);

    try {
      UserCredential userCredential =
          await FirebaseConfig.auth.signInWithCredential(credential);

      // ignore: use_build_context_synchronously
      statusForProviderConfirmation =
          await userCreatedVerification(userCredential, phoneNumber);
    } catch (e) {}

    return statusForProviderConfirmation;
  }

  Future<bool> userCreatedVerification(
      UserCredential userCredential, String phoneNumber) async {
    bool userCreatedStatus = false;
    if (userCredential.user != null) {
      DocumentSnapshot snapshot = await FirebaseConfig.db
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      if (snapshot.exists) {
        userCreatedStatus = true;
      }
    }

    return userCreatedStatus;
  }
}
