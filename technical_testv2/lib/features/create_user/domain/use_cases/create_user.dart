import 'package:dartz/dartz.dart';

import '../entities/user_entitites.dart';
import '../repositories/create_user_repository.dart';

class CreateUserInfo {
  CreateUserInfoRepository createUserRepository;

  CreateUserInfo({required this.createUserRepository});

  Future<Either<User, Map<String, dynamic>>> call(String userId) async {
    return createUserRepository.createUser(userId);
  }
}
