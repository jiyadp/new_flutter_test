import 'package:eminencetel/features/data/models/fiber_hope_model.dart';

abstract class LocalFiberHopeRepository {
  setFiberHope(FiberHopeModel params);

  FiberHopeModel getFiberHope();
}
