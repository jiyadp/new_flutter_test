import 'package:dartz/dartz.dart';
import 'package:eminencetel/core/error/failure.dart';
import 'package:eminencetel/core/usecases/usecase.dart';
import 'package:eminencetel/features/data/models/certificates_model.dart';
import 'package:eminencetel/features/domain/repositories/certificate_repository.dart';

class CertificatesUseCase implements UseCase<CertificatesModel, String> {
  final CertificateRepository repository;

  CertificatesUseCase(this.repository);

  @override
  Future<Either<Failure, CertificatesModel>> call(String userId) {
    return repository.getCertificates(userId);
  }
}
