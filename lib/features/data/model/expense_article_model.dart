import '../../domain/entity/expense_article.dart';
import 'package:floor/floor.dart';

@Entity(tableName: 'expense', primaryKeys: ['time'])
@TypeConverters([DateTimeConverter])
class ExpenseArticleModel extends ExpenseArticle {
  ExpenseArticleModel({
    required super.expenseType,
    required super.time,
    required super.name,
    required super.cost,
    required super.currencyName,
    required super.quantity,
    required super.netPrice,
  });

  factory ExpenseArticleModel.fromEntity(ExpenseArticle entity) {
    return ExpenseArticleModel(
      expenseType: entity.expenseType,
      time: entity.dateTime,
      name: entity.name,
      cost: entity.cost,
      currencyName: entity.currencyName,
      quantity: entity.quantity,
      netPrice: entity.netPrice,
    );
  }
}
class DateTimeConverter extends TypeConverter<DateTime, int> {
  @override
  DateTime decode(int databaseValue) {
    return DateTime.fromMillisecondsSinceEpoch(databaseValue);
  }

  @override
  int encode(DateTime value) {
    return value.millisecondsSinceEpoch;
  }
}
