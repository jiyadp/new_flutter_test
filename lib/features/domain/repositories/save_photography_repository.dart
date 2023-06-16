import 'package:dartz/dartz.dart';
import 'package:eminencetel/core/error/failure.dart';
import 'package:eminencetel/features/data/models/photos_model.dart';
import 'package:eminencetel/features/data/models/save_photography_model.dart';

abstract class SavePhotographyRepository {
  // //Todo change params
  // Future<Either<Failure, SavePhotographyModel>> save(FiberHopeModel params);
  // Future<Either<Failure, SavePhotographyModel>> update(FiberHopeModel params);

  Future<Either<Failure, SavePhotographyModel>> savePhotography(
      CategoriesData params);
}
