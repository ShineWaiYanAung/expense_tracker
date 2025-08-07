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
class GetFilterExpense extends LocalExpenseEvent{
  final String ownerId;
  const GetFilterExpense( {required this.ownerId});
}
class RemoveExpense extends LocalExpenseEvent{
  const RemoveExpense(ExpenseArticle expenseArticle) : super(expenseArticle: expenseArticle);
}
class EditExpense extends LocalExpenseEvent{
  const EditExpense(ExpenseArticle expenseArticle) : super(expenseArticle: expenseArticle);
}
class InsertExpense extends LocalExpenseEvent{
  const InsertExpense(ExpenseArticle expenseArticle) : super(expenseArticle: expenseArticle);
}
class FilterExpenseByType extends LocalExpenseEvent {
  final ExpenseType? type; // null means show all

  const FilterExpenseByType(this.type);
  
}