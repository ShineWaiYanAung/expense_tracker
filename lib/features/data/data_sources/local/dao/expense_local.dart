import 'package:floor/floor.dart';
import 'package:expense_tracker/features/data/model/expense_article_model.dart';

@dao
abstract class ExpenseDao {
  @Insert()
  Future<void> insertArticle(ExpenseArticleModel expense);
  @delete
  Future<void> deleteArticle(ExpenseArticleModel expense);
  @update
  Future<void> updateArticle(ExpenseArticleModel expense);
  @Query('SELECT * FROM expense')
  Future<List<ExpenseArticleModel>> getArticle();
}
