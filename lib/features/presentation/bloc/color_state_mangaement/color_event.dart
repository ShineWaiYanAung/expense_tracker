import 'package:equatable/equatable.dart';

import '../../../config/theme/theme.dart';


abstract class ThemeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// Event for changing theme
class ChangeThemeEvent extends ThemeEvent {
  final AppThemeColor selectedTheme;
  ChangeThemeEvent({required this.selectedTheme});

  @override
  List<Object> get props => [selectedTheme];
}
