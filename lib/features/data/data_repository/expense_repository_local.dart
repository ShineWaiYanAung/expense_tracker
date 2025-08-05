import 'package:expense_tracker/features/data/data_sources/local/local_expense_database.dart';
import 'package:expense_tracker/features/data/model/expense_article_model.dart';
import 'package:expense_tracker/features/domain/entity/expense_article.dart';
import 'package:expense_tracker/features/domain/repository/expense_repository.dart';

class ExpenseImplLocal implements ExpenseRepository{
  late final AppDataBase _appDataBase;
  ExpenseImplLocal(this._appDataBase);
  @override
  Future<void> deleteExpense(ExpenseArticle expense) {
    // TODO: implement deleteExpense
    return _appDataBase.articleDAO.deleteArticle(ExpenseArticleModel.fromEntity(expense));
  }

  @override
  Future<void> editExpense(ExpenseArticle entity) {
    // TODO: implement editExpense
    return _appDataBase.articleDAO.updateArticle(ExpenseArticleModel.fromEntity(entity));
  }

  @override
  Future<List<ExpenseArticle>> getSavedExpense() {
    // TODO: implement getSavedExpense
    return _appDataBase.articleDAO.getArticle();
  }

  @override
  Future<void> saveExpense(ExpenseArticle expense) {
    // TODO: implement saveExpense
    return _appDataBase.articleDAO.insertArticle(ExpenseArticleModel.fromEntity(expense));
  }

}