import 'package:dartz/dartz.dart';
import 'package:eminencetel/core/error/exceptions.dart';
import 'package:eminencetel/core/error/failure.dart';
import 'package:eminencetel/features/data/data_sources/remote/certificates_remote_data_source.dart';
import 'package:eminencetel/features/data/models/certificates_model.dart';
import 'package:eminencetel/features/domain/repositories/certificate_repository.dart';

class CertificateRepositoryImpl implements CertificateRepository {
  final CertificatesRemoteDataSource remoteDataSource;

  CertificateRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, CertificatesModel>> getCertificates(
      String userId) async {
    try {
      return Right(await remoteDataSource.getCertificates(userId));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
