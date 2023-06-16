import 'package:dartz/dartz.dart';
import 'package:eminencetel/core/error/failure.dart';
import 'package:eminencetel/features/data/models/fiber_hope_model.dart';
import 'package:eminencetel/features/data/models/save_model.dart';

abstract class SaveRepository {
  Future<Either<Failure, SaveModel>> save(FiberHopeModel params);
  Future<Either<Failure, SaveModel>> update(FiberHopeModel params);
}
