import '../../../config/theme/theme.dart';
import 'package:equatable/equatable.dart';

class ThemeState extends Equatable {
  final AppTheme theme;
  ThemeState({required this.theme});

  @override
  // TODO: implement props
  List<Object?> get props => [theme];
}
