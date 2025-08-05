import 'package:expense_tracker/features/domain/entity/expense_article.dart';
import 'package:expense_tracker/features/domain/repository/expense_repository.dart';

import '../../../core/usecases/usecase.dart';

class RemoveExpenseUseCase implements UseCase<void, ExpenseArticle> {
  final ExpenseRepository _expenseRepository;
  RemoveExpenseUseCase(this._expenseRepository);
  @override
  Future<void> call({ExpenseArticle? params}) {
    // TODO: implement call
    return _expenseRepository.deleteExpense(params!);
  }
}
