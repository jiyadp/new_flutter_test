import 'package:dartz/dartz.dart';
import 'package:eminencetel/core/error/failure.dart';
import 'package:eminencetel/features/data/models/login_model.dart';
import 'package:eminencetel/features/domain/usecase/login_usecase.dart';

abstract class LoginRepository {
  Future<Either<Failure, LoginModel>> login(LoginParams params);

  bool getLoggedUser();

  LoginData getUser();
}
