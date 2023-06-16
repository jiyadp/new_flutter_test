import 'package:eminencetel/core/states/data_state.dart';
import 'package:eminencetel/features/data/models/login_model.dart';
import 'package:eminencetel/features/domain/usecase/login_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginCubit extends Cubit<DataState<LoginModel>> {
  final LoginUseCase loginUseCase;
  final SharedPreferences sharedPreferences;

  LoginCubit(this.loginUseCase,this.sharedPreferences) : super(DataState.initial());

  void login(String email, String password) async {
    emit(DataState.inProgress());
    final result =
        await loginUseCase(LoginParams(email: email, password: password));
    result.fold(
        (failure) =>
            emit(DataState.failure("Server Exception ${failure.toString()}")),
        (success) => {
              if (success.data != null && success.data?.id?.isNotEmpty == true)
                {emit(DataState.success(success))}
              else
                {emit(DataState.failure(success.message))}
            });
  }

  void isUserAlreadyLoggedIn() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    int buildNumber = int.parse(packageInfo.buildNumber);
    if(buildNumber < 21) {
      await sharedPreferences.clear();
    }

    final result = loginUseCase.loginRepository.getLoggedUser();
    if (result) {
      emit(DataState.success(const LoginModel()));
    }
  }

  LoginData getUser() {
    return loginUseCase.loginRepository.getUser();
  }

  // int getAppVersionCode() {
  //   return appRepository.getVersionCode();
  // }
  //
  // setAppVersionCode(int value) {
  //   appRepository.setVersionCode(value);
  // }

  /// this will delete cache
  Future<void> deleteCacheDir() async {
    final cacheDir = await getTemporaryDirectory();

    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
    }
  }

  /// this will delete app's storage
  Future<void> deleteAppDir() async {
    final appDir = await getApplicationSupportDirectory();

    if(appDir.existsSync()){
      appDir.deleteSync(recursive: true);
    }
  }
}
