import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulse_plateform/core/common/core_app_colors.dart';
import 'package:pulse_plateform/core/common/market_data_constant.dart';

import 'presentation/market_data_screen/root/market_data_list_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MarketDataConstant.pulsePlateFarm,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Modern color scheme with gradient-inspired colors
        colorScheme: ColorScheme.fromSeed(
          seedColor: CoreAppColors.primary,
          primary: CoreAppColors.primary,
          secondary: CoreAppColors.primaryAccent,
          surface: CoreAppColors.white,
          error: CoreAppColors.error,
          brightness: Brightness.light,
        ),

        useMaterial3: true,

        // Enhanced AppBar theme
        appBarTheme: AppBarTheme(
          elevation: 0,
          centerTitle: true,
          backgroundColor: CoreAppColors.white,
          foregroundColor: CoreAppColors.textPrimary,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: CoreAppColors.textPrimary,
            letterSpacing: 0.5,
          ),
        ),

        // Modern card theme
        cardTheme: CardTheme(
          elevation: 2,
          shadowColor: CoreAppColors.cardShadow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),

        // Enhanced elevated button theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 2,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),

        // Smooth page transitions
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),

        // Typography
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1A2E),
          ),
          displayMedium: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1A2E),
          ),
          displaySmall: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A1A2E),
          ),
          headlineMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A1A2E),
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: Color(0xFF4A4A68),
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Color(0xFF6B6B87),
          ),
        ),

        // Input decoration theme
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFF5F5F8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xFF6C63FF),
              width: 2,
            ),
          ),
        ),

        // Icon theme
        iconTheme: const IconThemeData(
          color: Color(0xFF6C63FF),
          size: 24,
        ),

        // Divider theme
        dividerTheme: const DividerThemeData(
          color: Color(0xFFE8E8F0),
          thickness: 1,
          space: 1,
        ),
      ),
      home: const MarketDataListScreen(),
    );
  }
}
