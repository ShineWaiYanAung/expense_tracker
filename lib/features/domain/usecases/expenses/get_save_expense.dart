import 'package:expense_tracker/features/core/usecases/usecase.dart';
import 'package:expense_tracker/features/domain/entity/expense_article.dart';
import 'package:expense_tracker/features/domain/repository/expense_repository.dart';

class GetSavedArticleUseCase implements UseCase<List<ExpenseArticle>,void>{
  final ExpenseRepository _expenseRepository;
  GetSavedArticleUseCase(this._expenseRepository);
  @override
  Future<List<ExpenseArticle>> call({void params}){
    return _expenseRepository.getSavedExpense();
  }
}