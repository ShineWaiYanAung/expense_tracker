import '../../data/model/auth_model.dart';
import 'package:expense_tracker/features/domain/entity/auth_article.dart';
abstract class AuthRepository {
  Future<List<AuthEntity>> getSavedAuth(); // for fetching all accounts
  Future<void> saveAuth(AuthEntity auth);
  Future<void> deleteAuth(AuthEntity auth);
  Future<void> editAuth(AuthEntity auth);
}
