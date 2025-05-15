import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../config/theme/theme.dart';
import 'color_event.dart';
import 'color_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc(AppThemeColor initialTheme)
      : super(ThemeState(theme: AppThemeFactory.getAppThemeFactory(initialTheme))) {
    on<ChangeThemeEvent>(_onChangeTheme);
  }

  static const _themeKey = 'selected_theme';

  Future<void> _onChangeTheme(ChangeThemeEvent event, Emitter<ThemeState> emit) async {
    emit(ThemeState(theme: AppThemeFactory.getAppThemeFactory(event.selectedTheme)));

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, event.selectedTheme.name);
  }

  static Future<AppThemeColor> loadSavedTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString(_themeKey);

    return AppThemeColor.values.firstWhere(
          (e) => e.name == savedTheme,
      orElse: () => AppThemeColor.brown,
    );
  }
}
