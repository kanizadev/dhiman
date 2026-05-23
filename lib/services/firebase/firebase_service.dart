import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import 'firebase_options.dart';

class FirebaseService {
  static bool _initialized = false;
  static bool get isInitialized => _initialized;
  static bool get isDemoMode => !_initialized || !DefaultFirebaseOptions.isConfigured;

  static Future<bool> initialize() async {
    if (_initialized) return true;
    if (!DefaultFirebaseOptions.isConfigured) {
      debugPrint('ধীমান: Firebase not configured — running in demo mode.');
      return false;
    }
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      _initialized = true;
      return true;
    } catch (e) {
      debugPrint('ধীমান: Firebase init failed: $e');
      return false;
    }
  }
}
