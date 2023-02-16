import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/user.dart';

const String kIsUserLoggedInKey = "is user logged in";
const String kUser = 'user';

class AuthPreference {
  final SharedPreferences _sharedPreferences;

  AuthPreference(
    this._sharedPreferences,
  );

  bool isUserLoggedIn() {
    return _sharedPreferences.getBool(kIsUserLoggedInKey) ?? false;
  }

  void setUserLoggedIn() {
    _sharedPreferences.setBool(kIsUserLoggedInKey, true);
  }

  void setUserLoggedOut() {
    _sharedPreferences.setBool(kIsUserLoggedInKey, false);
  }

  void setUser(User user) {
    _sharedPreferences.setString(kUser, user.toJson());
  }

  User getUser() {
    return User.fromJson(_sharedPreferences.getString(kUser) ?? '');
  }
}
