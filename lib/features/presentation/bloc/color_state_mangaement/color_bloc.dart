import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/theme/theme.dart';
import 'color_event.dart';
import 'color_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
    : super(
        ThemeState(
          theme: AppThemeFactory.getAppThemeFactory(AppThemeColor.brown),
        ),
      ) {
    on<ChangeThemeEvent>((event, emit) {
      emit(
        ThemeState(
          theme: AppThemeFactory.getAppThemeFactory(event.selectedTheme),
        ),
      );
    });
  }
}
