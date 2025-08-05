import 'package:expense_tracker/features/domain/entity/expense_article.dart';
import 'package:expense_tracker/features/domain/repository/expense_repository.dart';

import '../../../core/usecases/usecase.dart';

class SaveExpenseUseCase implements UseCase<void ,ExpenseArticle>{
  final ExpenseRepository _expenseRepository;

  SaveExpenseUseCase(this._expenseRepository);

  @override
  Future<void> call({ExpenseArticle ? params}){
    return _expenseRepository.saveExpense(params!);
  }
}