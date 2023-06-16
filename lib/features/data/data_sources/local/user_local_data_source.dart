import 'dart:convert';

import 'package:eminencetel/features/data/models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserLocalDataSource {
  bool isUserAlreadyLoggedIn();

  setUserAlreadyLoggedIn(bool value);

  setUser(LoginData? loginData);

  LoginData getUser();
}

const userAlreadyLoggedIn = 'USER_ALREADY_LOGGED_IN';
const user = 'USER';

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final SharedPreferences sharedPreferences;

  UserLocalDataSourceImpl(this.sharedPreferences);

  @override
  bool isUserAlreadyLoggedIn() {
    var result = sharedPreferences.getBool(userAlreadyLoggedIn);
    if (result != null) {
      return result;
    } else {
      return false;
    }
  }

  @override
  setUserAlreadyLoggedIn(bool value) async {
    await sharedPreferences.setBool(userAlreadyLoggedIn, value);
  }

  @override
  setUser(LoginData? loginData) async {
    String loginDataString = json.encode(loginData?.toJson());
    await sharedPreferences.setString(user, loginDataString);
  }

  @override
  LoginData getUser() {
    var result = sharedPreferences.getString(user);
    if (result?.isNotEmpty == true) {
      return LoginData.fromJson(json.decode(result!));
    } else {
      return LoginData();
    }
  }
}
