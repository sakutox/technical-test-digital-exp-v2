// import 'package:provider/provider.dart';
// import 'package:dartz/dartz.dart';
// import '../../domain/entities/user_entitites.dart';
// import '../../domain/repositories/create_user_repository.dart';
// import '../datasources/remote_datasource.dart';

// class CreateUserInfoRepositoryImpl implements CreateUserInfoRepository {
//   RemoteDataSource dataSource;
//   CreateUserInfoRepositoryImpl(this.dataSource);

//   @override
//   Future<Either<User, Map<String, dynamic>>> createUser(String userId) async {
//     try {
//       final result = await dataSource.createUser(userId);
//       return left();
//     } catch (e) {
//       return right({
//         "status": "fail",
//         "message": "$e",
//       });
//     }
//   }
// }
