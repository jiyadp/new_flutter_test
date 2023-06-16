import 'package:eminencetel/core/states/data_state.dart';
import 'package:eminencetel/features/domain/usecase/login_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashCubit extends Cubit<DataState<bool>> {
  final LoginUseCase loginUseCase;

  SplashCubit(this.loginUseCase) : super(DataState.initial());

  void isUserAlreadyLoggedIn() async {
    final result = loginUseCase.loginRepository.getLoggedUser();
    if (result) {
      emit(DataState.success(result));
    }
  }
}
