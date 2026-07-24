import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

/// Which of the two themes to use.
///
/// Starts at [ThemeMode.system] so a fresh install matches the device rather than
/// forcing light — the previous behaviour, which meant a user on a dark phone got
/// a bright app until they found the toggle.
class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);

  /// Flips to the opposite of what is currently on screen.
  ///
  /// Takes the effective brightness rather than reading [state], because while
  /// the mode is [ThemeMode.system] the state alone does not say which theme is
  /// actually being displayed.
  void toggleTheme({required bool isCurrentlyDark}) {
    emit(isCurrentlyDark ? ThemeMode.light : ThemeMode.dark);
  }

  void setMode(ThemeMode mode) => emit(mode);
}
