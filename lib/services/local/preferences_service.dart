import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const _keyOnboardingDone = 'onboarding_done';
  static const _keyThemeMode = 'theme_mode';
  static const _keyLastUid = 'last_uid';

  Future<SharedPreferences> get _prefs => SharedPreferences.getInstance();

  Future<bool> isOnboardingDone() async {
    final prefs = await _prefs;
    return prefs.getBool(_keyOnboardingDone) ?? false;
  }

  Future<void> setOnboardingDone(bool value) async {
    final prefs = await _prefs;
    await prefs.setBool(_keyOnboardingDone, value);
  }

  Future<String?> getThemeMode() async {
    final prefs = await _prefs;
    return prefs.getString(_keyThemeMode);
  }

  Future<void> setThemeMode(String mode) async {
    final prefs = await _prefs;
    await prefs.setString(_keyThemeMode, mode);
  }

  Future<void> saveLastUid(String uid) async {
    final prefs = await _prefs;
    await prefs.setString(_keyLastUid, uid);
  }

  Future<String?> getLastUid() async {
    final prefs = await _prefs;
    return prefs.getString(_keyLastUid);
  }
}
