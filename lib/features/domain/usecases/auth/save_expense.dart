import 'package:expense_tracker/features/domain/entity/auth_article.dart';
import '../../../core/usecases/usecase.dart';
import '../../../data/model/auth_model.dart';
import '../../repository/auth_repository.dart';

class SaveAuthUseCase implements UseCase<void, AuthEntity> {
  final AuthRepository _authRepository;

  SaveAuthUseCase(this._authRepository);

  @override
  Future<void> call({AuthEntity? params}) {
    return _authRepository.saveAuth(params!);
  }
}
