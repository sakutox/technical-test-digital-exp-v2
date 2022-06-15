import 'package:provider/provider.dart';
import 'package:technical_testv2/features/create_user/display/providers/create_user_provider.dart';
import 'package:technical_testv2/features/create_user/domain/repositories/verify_phone_repository.dart';
import 'package:dartz/dartz.dart';
import '../entities/user_entitites.dart';

class VerifyPhoneNumber {
  VerifyPhoneNumberRepository verifyPhoneNumberRepository;

  VerifyPhoneNumber({required this.verifyPhoneNumberRepository});

  Future<Map<String, dynamic>> call(
      String phoneNumber, CreateUserProvider provider) async {
    return verifyPhoneNumberRepository.verifyPhoneNumber(phoneNumber, provider);
  }
}
