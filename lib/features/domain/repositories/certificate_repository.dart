import 'package:dartz/dartz.dart';
import 'package:eminencetel/core/error/failure.dart';
import 'package:eminencetel/features/data/models/certificates_model.dart';

abstract class CertificateRepository {
  Future<Either<Failure, CertificatesModel>> getCertificates(String userId);
}
