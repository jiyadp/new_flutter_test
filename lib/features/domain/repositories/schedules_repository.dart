import 'package:dartz/dartz.dart';
import 'package:eminencetel/core/error/failure.dart';
import 'package:eminencetel/features/data/models/schedules_model.dart';

abstract class SchedulesRepository {
  Future<Either<Failure, SchedulesModel>> getSchedules(String userId);
  SchedulesModel getSchedulesFromCache(String userId);
}
