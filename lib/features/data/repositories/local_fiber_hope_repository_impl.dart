import 'package:eminencetel/features/data/data_sources/local/local_fiber_hope_data_source.dart';
import 'package:eminencetel/features/data/models/fiber_hope_model.dart';
import 'package:eminencetel/features/domain/repositories/local_fiber_hope_repository.dart';

class LocalFiberHopeRepositoryImpl implements LocalFiberHopeRepository {
  final LocalFiberHopeDataSource localFiberHopeDataSource;

  LocalFiberHopeRepositoryImpl(this.localFiberHopeDataSource);

  @override
  FiberHopeModel getFiberHope() {
    return localFiberHopeDataSource.getFiberHopeData();
  }

  @override
  setFiberHope(FiberHopeModel params) {
    localFiberHopeDataSource.setFiberHopeData(params);
  }
}
