import 'package:eminencetel/core/usecases/local_usecase.dart';
import 'package:eminencetel/features/data/models/fiber_hope_model.dart';
import 'package:eminencetel/features/domain/repositories/local_fiber_hope_repository.dart';

class LocalFiberHopeSetUseCase implements LocalUseCase<void, FiberHopeModel> {
  final LocalFiberHopeRepository localFiberHopeRepository;

  LocalFiberHopeSetUseCase(this.localFiberHopeRepository);

  @override
  void invoke(FiberHopeModel params) {
    localFiberHopeRepository.setFiberHope(params);
  }
}
