import 'package:e_commerce_app/core/errors/exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class OnBoardingLocalDataSource {
  const OnBoardingLocalDataSource();

  Future<void> cacheFirstTimer();

  Future<bool> checkIfUserIsFirstTimer();
}

const kFirstTimerKey = 'first_timer';
const kUserLoggedInKey = 'user_logged_in';

class OnBoardingLocalDataSourceImpl extends OnBoardingLocalDataSource {
  const OnBoardingLocalDataSourceImpl(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  @override
  Future<void> cacheFirstTimer() async {
    try {
      await _sharedPreferences.setBool(kFirstTimerKey, false);
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<bool> checkIfUserIsFirstTimer() async {
    try {
      return _sharedPreferences.getBool(kFirstTimerKey) ?? true;
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }
}
