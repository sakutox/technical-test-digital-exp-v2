import 'package:dartz/dartz.dart';
import '../entities/user_entitites.dart';

abstract class CreateUserInfoRepository {
  Future<Either<User, Map<String, dynamic>>> createUser(String userId);
}
