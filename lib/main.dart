import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ============================================================
//  NOIR — Premium Fashion App
//  Refactored: Performance · Design · UX
//  Brand: NOIR | Palette: Black / White / Champagne Gold
// ============================================================

import 'package:shared_preferences/shared_preferences.dart';
import 'package:aura_app/app.dart';
import 'package:aura_app/providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    debugPrint('Flutter Error: ${details.exception}');
  };

  try {
    final prefs = await SharedPreferences.getInstance();

    SystemChrome.setPreferredOrientations(const [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    runApp(ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const NoirApp(),
    ));
  } catch (e, stack) {
    debugPrint('Initialization Error: $e');
    debugPrint('Stack: $stack');
    // Fallback if prefs fail
    runApp(const MaterialApp(
      home: Scaffold(body: Center(child: Text('Error initializing app'))),
    ));
  }
}
