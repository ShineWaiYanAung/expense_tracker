import 'package:expense_tracker/features/domain/entity/auth_article.dart';
import '../../../core/usecases/usecase.dart';
import '../../repository/auth_repository.dart';

class EditAuthUseCase implements UseCase<void, AuthEntity> {
  final AuthRepository _authRepository;

  EditAuthUseCase(this._authRepository);

  @override
  Future<void> call({AuthEntity? params}) {
    return _authRepository.editAuth(params!);
  }
}
