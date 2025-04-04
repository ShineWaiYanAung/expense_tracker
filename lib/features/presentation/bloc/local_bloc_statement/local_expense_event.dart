import 'package:equatable/equatable.dart';
import 'package:expense_tracker/features/domain/entity/expense_article.dart';
abstract class LocalExpenseEvent extends Equatable{
  final ExpenseArticle? expenseArticle;
  const LocalExpenseEvent({this.expenseArticle});

  @override
  List<Object>get props => [expenseArticle!];
}
class GetSavedExpense extends LocalExpenseEvent{
  const GetSavedExpense();
}
class RemoveExpense extends LocalExpenseEvent{
  const RemoveExpense();
}
class EditExpense extends LocalExpenseEvent{
  const EditExpense();
}
class InsertExpense extends LocalExpenseEvent{
  const InsertExpense();
}