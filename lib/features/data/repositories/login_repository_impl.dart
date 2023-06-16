import 'package:dartz/dartz.dart';
import 'package:eminencetel/core/error/exceptions.dart';
import 'package:eminencetel/core/error/failure.dart';
import 'package:eminencetel/core/network/network_info.dart';
import 'package:eminencetel/features/data/data_sources/local/user_local_data_source.dart';
import 'package:eminencetel/features/data/data_sources/remote/login_remote_data_source.dart';
import 'package:eminencetel/features/data/models/login_model.dart';
import 'package:eminencetel/features/domain/repositories/login_repository.dart';
import 'package:eminencetel/features/domain/usecase/login_usecase.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource loginRemoteDataSource;
  final UserLocalDataSource userLocalDataSource;
  final NetworkInfo networkInfo;

  LoginRepositoryImpl(
      this.loginRemoteDataSource, this.userLocalDataSource, this.networkInfo);

  @override
  Future<Either<Failure, LoginModel>> login(LoginParams params) async {
    try {
      var result = await loginRemoteDataSource.login(params);
      // Cache login result
      if (result.data != null && result.success == true) {
        userLocalDataSource.setUser(result.data);
        userLocalDataSource.setUserAlreadyLoggedIn(true);
      }
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  bool getLoggedUser() {
    return userLocalDataSource.isUserAlreadyLoggedIn();
  }

  @override
  LoginData getUser() {
    return userLocalDataSource.getUser();
  }
}
