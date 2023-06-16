import 'dart:convert';
import 'package:eminencetel/features/data/models/photos_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class DynamicPhotosTabLocalDataSource {
  CategoriesData getUserEnteredData();
  setUserEnteredData(CategoriesData? dynamicPhotosData);
}

const userEnteredDynamicPhotosTabData = 'USER_ENTERED_DYNAMIC_PHOTOS_TAB_DATA';

class DynamicPhotosTabLocalDataSourceImpl
    implements DynamicPhotosTabLocalDataSource {
  final SharedPreferences sharedPreferences;

  DynamicPhotosTabLocalDataSourceImpl(this.sharedPreferences);

  @override
  CategoriesData getUserEnteredData() {
    var result = sharedPreferences.getString(userEnteredDynamicPhotosTabData);
    if (result?.isNotEmpty == true) {
      return CategoriesData.fromJson(json.decode(result!));
    } else {
      return CategoriesData();
    }
  }

  @override
  setUserEnteredData(CategoriesData? dynamicPhotosTabData) async {
    String dynamicPhotosString = json.encode(dynamicPhotosTabData?.toJson());
    await sharedPreferences.setString(
        userEnteredDynamicPhotosTabData, dynamicPhotosString);
  }
}
