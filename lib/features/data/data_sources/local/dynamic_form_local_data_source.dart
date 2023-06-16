import 'dart:convert';

import 'package:eminencetel/features/data/models/dynamic_form_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class DynamicFormLocalDataSource {
  DynamicFormData getUserEnteredData();
  setUserEnteredData(DynamicFormData? dynamicFormData);
}

const userEnteredDynamicFormData = 'USER_ENTERED_DYNAMIC_FORM_DATA';

class DynamicFormLocalDataSourceImpl implements DynamicFormLocalDataSource {
  final SharedPreferences sharedPreferences;

  DynamicFormLocalDataSourceImpl(this.sharedPreferences);

  @override
  DynamicFormData getUserEnteredData() {
    var result = sharedPreferences.getString(userEnteredDynamicFormData);

    if (result?.isNotEmpty == true) {
      return DynamicFormData.fromJson(json.decode(result!));
    } else {
      return DynamicFormData();
    }
  }

  @override
  setUserEnteredData(DynamicFormData? dynamicFormData) async {
    String dynamicFormString = json.encode(dynamicFormData?.toJson());
    await sharedPreferences.setString(
        userEnteredDynamicFormData, dynamicFormString);
  }
}
