import 'package:dartz/dartz.dart';
import 'package:provider/provider.dart';
import 'package:technical_testv2/features/create_user/display/providers/create_user_provider.dart';
import '../entities/user_entitites.dart';

abstract class VerifyPhoneNumberRepository {
  Future<Map<String, dynamic>> verifyPhoneNumber(
      String phoneNumber, CreateUserProvider provider);
}
