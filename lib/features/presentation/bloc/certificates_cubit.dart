import 'package:eminencetel/core/no_params.dart';
import 'package:eminencetel/core/states/data_state.dart';
import 'package:eminencetel/features/data/models/certificates_model.dart';
import 'package:eminencetel/features/domain/usecase/certificates_usecase.dart';
import 'package:eminencetel/features/domain/usecase/user_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CertificatesCubit extends Cubit<DataState<CertificatesModel>> {
  final CertificatesUseCase certificatesUseCase;
  final UserUseCase userUseCase;

  CertificatesCubit(this.certificatesUseCase, this.userUseCase)
      : super(DataState.initial());

  void getCertificates() async {
    emit(DataState.inProgress());
    final result = await certificatesUseCase(
        userUseCase.invoke(const NoParams()).id ?? "");
    result.fold(
        (failure) => emit(DataState.failure("Server Exception")),
        (success) => {
              if (success.data?.isNotEmpty == true)
                {emit(DataState.success(success))}
              else
                {emit(DataState.empty())}
            });
  }
}
