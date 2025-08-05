import 'package:expense_tracker/features/domain/entity/auth_article.dart';
import '../../../core/usecases/usecase.dart';
import '../../../data/model/auth_model.dart';
import '../../repository/auth_repository.dart';

class GetSavedAuthUseCase implements UseCase<List<AuthEntity>, void> {
  final AuthRepository _authRepository;

  GetSavedAuthUseCase(this._authRepository);

  @override
  Future<List<AuthEntity>> call({void params}) {
    return _authRepository.getSavedAuth();
  }
}

