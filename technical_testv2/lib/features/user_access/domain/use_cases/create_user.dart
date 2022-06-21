import 'package:dartz/dartz.dart';
import 'package:technical_testv2/features/user_access/data/models/user_model.dart';

import '../entities/user_entitites.dart';
import '../repositories/create_user_repository.dart';

class CreateUserInfo {
  CreateUserInfoRepository createUserRepository;

  CreateUserInfo({required this.createUserRepository});

  Future<Either<User, Map<String, dynamic>>> call(UserModel user) async {
    return createUserRepository.createUser(user);
  }
}
