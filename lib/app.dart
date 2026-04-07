import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:aura_app/core/theme/app_theme.dart';
import 'package:aura_app/providers/theme_provider.dart';
import 'package:aura_app/router/app_router.dart';

class NoirApp extends ConsumerWidget {
  const NoirApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'NOIR',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      darkTheme: buildDarkTheme(),
      themeMode: themeMode,
      routerConfig: router,
    );
  }
}

/// Optimized network image with shimmer loading
