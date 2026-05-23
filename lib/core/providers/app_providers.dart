import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/auth/auth_service.dart';
import '../../services/firestore/user_repository.dart';
import '../../services/local/preferences_service.dart';

final preferencesServiceProvider = Provider<PreferencesService>((ref) {
  return PreferencesService();
});

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository();
});

final themeModeProvider =
    NotifierProvider<ThemeModeNotifier, ThemeMode>(ThemeModeNotifier.new);

class ThemeModeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    _load();
    return ThemeMode.system;
  }

  Future<void> _load() async {
    final prefs = ref.read(preferencesServiceProvider);
    final saved = await prefs.getThemeMode();
    if (saved == 'light') state = ThemeMode.light;
    if (saved == 'dark') state = ThemeMode.dark;
  }

  Future<void> setTheme(ThemeMode mode) async {
    state = mode;
    final prefs = ref.read(preferencesServiceProvider);
    await prefs.setThemeMode(mode.name);
  }
}
