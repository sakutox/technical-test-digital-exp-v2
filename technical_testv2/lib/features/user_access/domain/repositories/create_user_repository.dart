import 'package:dartz/dartz.dart';
import 'package:technical_testv2/features/user_access/data/models/user_model.dart';
import '../entities/user_entitites.dart';

abstract class CreateUserInfoRepository {
  Future<Either<User, Map<String, dynamic>>> createUser(UserModel user);
}
