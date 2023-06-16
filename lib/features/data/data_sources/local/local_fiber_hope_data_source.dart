import 'dart:convert';

import 'package:eminencetel/features/data/models/fiber_hope_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalFiberHopeDataSource {
  setFiberHopeData(FiberHopeModel fiberHopeModel);
  FiberHopeModel getFiberHopeData();
}

const fiberHopeData = 'FIBER_HOPE_DATA';

class LocalFiberHopeDataSourceImpl implements LocalFiberHopeDataSource {
  final SharedPreferences sharedPreferences;
  LocalFiberHopeDataSourceImpl(this.sharedPreferences);

  @override
  FiberHopeModel getFiberHopeData() {
    var result = sharedPreferences.getString(fiberHopeData);
    if (result?.isNotEmpty == true) {
      return FiberHopeModel.fromJson(json.decode(result!));
    } else {
      return FiberHopeModel();
    }
  }

  @override
  setFiberHopeData(FiberHopeModel fiberHopeModel) {
    String cacheString = json.encode(fiberHopeModel.toJson());
    sharedPreferences.setString(fiberHopeData, cacheString);
  }
}
