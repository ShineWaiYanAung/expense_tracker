
import '../../../FireBase/FireBaseStore/fire_base_store_expense_service.dart';
import '../../../FireBase/FireBaseStore/fire_base_store_service.dart';
import '../../domain/entity/expense_article.dart';
import '../../domain/repository/expense_repository.dart';
import '../model/expense_article_model.dart';

class ExpenseImplFireBase implements ExpenseRepository {
  final FirebaseStoreServiceExpense _firebaseService;

  ExpenseImplFireBase(this._firebaseService);

  @override
  Future<void> saveExpense(ExpenseArticle expense) {
    return _firebaseService.addExpense(ExpenseArticleModel.fromEntity(expense));
  }

  @override
  Future<void> editExpense(ExpenseArticle expense) {
    return _firebaseService.updateExpense(ExpenseArticleModel.fromEntity(expense));
  }

  @override
  Future<void> deleteExpense(ExpenseArticle expense) {
    return _firebaseService.deleteExpense(ExpenseArticleModel.fromEntity(expense));
  }

  @override
  Future<List<ExpenseArticle>> getSavedExpense() {
    return _firebaseService.fetchExpenses();
  }
}
