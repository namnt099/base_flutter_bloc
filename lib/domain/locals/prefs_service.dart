import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';


class PrefsService {
  static const _PREF_TOKEN_KEY = 'pref_token_key';
  static const _PREF_FIRST = 'pref_first_key';

  static SharedPreferences? _prefsInstance;

  static Future<SharedPreferences> get _instance async =>
      _prefsInstance ??= await SharedPreferences.getInstance();

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance!;
  }

  static Future<bool> saveToken(String value) async {
    final prefs = await _instance;
    return prefs.setString(_PREF_TOKEN_KEY, value);
  }

  static String getToken() {
    return _prefsInstance?.getString(_PREF_TOKEN_KEY) ?? '';
  }

  static Future<bool> saveFirstLaunch(bool value) async {
    final prefs = await _instance;
    return prefs.setBool(_PREF_FIRST, value);
  }

  static bool get getFirstLaunch =>
      _prefsInstance?.getBool(_PREF_FIRST) ?? true;

  static Future<void> clearAuthData() async {
    await _prefsInstance?.remove(_PREF_TOKEN_KEY);
  }

  static Future<void> clearData() async {
    await _prefsInstance?.clear();
    return;
  }
}
