import 'package:shared_preferences/shared_preferences.dart';

const String kIsUserLoggedInKey = "is user logged in";
const String kIsOnBoardingScreenViewedKey = "is onBoarding screen viewed";

class AuthPreferences {
  final SharedPreferences _sharedPreferences;

  AuthPreferences(this._sharedPreferences);

  bool isUserLoggedIn() {
    return _sharedPreferences.getBool(kIsUserLoggedInKey) ?? false;
  }

  void setUserLoggedIn() {
    _sharedPreferences.setBool(kIsUserLoggedInKey, true);
  }

  void setUserLoggedOut() {
    _sharedPreferences.setBool(kIsUserLoggedInKey, false);
  }

  bool isOnBoardingScreenViewed() {
    return _sharedPreferences.getBool(kIsOnBoardingScreenViewedKey) ?? false;
  }

  void setOnBoardingScreenViewed() {
    _sharedPreferences.setBool(kIsOnBoardingScreenViewedKey, true);
  }
}
