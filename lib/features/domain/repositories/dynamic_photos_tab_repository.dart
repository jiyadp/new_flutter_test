import 'package:dartz/dartz.dart';
import 'package:eminencetel/core/error/failure.dart';
import 'package:eminencetel/features/data/models/dynamic_photos_tab_model.dart';
import 'package:eminencetel/features/domain/usecase/dynamic_photos_tab_usecase.dart';

abstract class DynamicPhotosTabRepository {
  Future<Either<Failure, DynamicPhotosTabModel>> getDynamicPhotosTabData(
      DynamicPhotosTabParams params);
}
