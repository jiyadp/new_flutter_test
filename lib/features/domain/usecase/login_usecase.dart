import 'package:eminencetel/core/error/failure.dart';
import 'package:eminencetel/core/usecases/usecase.dart';
import 'package:eminencetel/features/data/models/login_model.dart';
import 'package:eminencetel/features/domain/repositories/login_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class LoginUseCase implements UseCase<LoginModel, LoginParams> {
  final LoginRepository loginRepository;

  LoginUseCase(this.loginRepository);

  @override
  Future<Either<Failure, LoginModel>> call(LoginParams params) {
    return loginRepository.login(params);
  }
}

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
