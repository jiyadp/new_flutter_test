import 'package:eminencetel/core/no_params.dart';
import 'package:eminencetel/core/usecases/local_usecase.dart';
import 'package:eminencetel/features/data/models/fiber_hope_model.dart';
import 'package:eminencetel/features/domain/repositories/local_fiber_hope_repository.dart';

class LocalFiberHopeGetUseCase
    implements LocalUseCase<FiberHopeModel, NoParams> {
  final LocalFiberHopeRepository localFiberHopeRepository;

  LocalFiberHopeGetUseCase(this.localFiberHopeRepository);

  @override
  FiberHopeModel invoke(NoParams params) {
    return localFiberHopeRepository.getFiberHope();
  }
}
