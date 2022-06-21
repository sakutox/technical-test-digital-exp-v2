import 'package:dartz/dartz.dart';
import 'package:technical_testv2/features/user_access/data/models/user_model.dart';
import '../../domain/entities/user_entitites.dart';
import '../../domain/repositories/create_user_repository.dart';
import '../datasources/remote_datasource.dart';

class CreateUserInfoRepositoryImpl implements CreateUserInfoRepository {
  RemoteDataSource dataSource;
  CreateUserInfoRepositoryImpl(this.dataSource);

  @override
  Future<Either<User, Map<String, dynamic>>> createUser(UserModel user) async {
    try {
      final result = await dataSource.createUser(user);
      return left(user);
    } catch (e) {
      return right({
        "status": "fail",
        "message": "$e",
      });
    }
  }
}
