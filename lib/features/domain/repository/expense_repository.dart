import 'package:expense_tracker/features/domain/entity/expense_article.dart';

abstract class ExpenseRepository{


 //Local DataBase
 Future<List<ExpenseArticle>> getSavedExpense();

 Future<void> saveExpense(ExpenseArticle expense);

 Future<void> deleteExpense(ExpenseArticle expense);

 Future<void> editExpense(ExpenseArticle entity);

}