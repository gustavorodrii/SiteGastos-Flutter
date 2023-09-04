import 'package:flutter/material.dart';

part 'color_schemes.dart';

ThemeData get lightTheme => ThemeData(
      useMaterial3: true,
      colorScheme: _lightColorScheme,
      appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(
          color: _lightColorScheme.onPrimary,
          fontSize: 18,
        ),
        backgroundColor: _lightColorScheme.primary,
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.all(
          _lightColorScheme.primary,
        ),
      ),
    );

ThemeData get darkTheme => ThemeData(
      useMaterial3: true,
      colorScheme: _darkColorScheme,
      appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(
          color: _darkColorScheme.onPrimary,
          fontSize: 18,
        ),
        backgroundColor: _darkColorScheme.primary,
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.all(
          _darkColorScheme.primary,
        ),
      ),
    );
