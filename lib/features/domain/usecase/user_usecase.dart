import 'package:eminencetel/core/no_params.dart';
import 'package:eminencetel/core/usecases/local_usecase.dart';
import 'package:eminencetel/features/data/models/login_model.dart';
import 'package:eminencetel/features/domain/repositories/login_repository.dart';

class UserUseCase implements LocalUseCase<LoginData, NoParams> {
  final LoginRepository repository;

  UserUseCase(this.repository);

  @override
  LoginData invoke(NoParams noParams) {
    return repository.getUser();
  }
}
