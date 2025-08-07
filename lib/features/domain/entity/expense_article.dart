import 'package:equatable/equatable.dart';
import 'package:expense_tracker/features/domain/entity/auth_article.dart';
import 'package:floor/floor.dart';

enum ExpenseType {
  bill,
  food,
  transport
}

// @TypeConverters([DateTimeConverter])
class ExpenseArticle extends Equatable {
  @PrimaryKey(autoGenerate: true)
  final String? id; // Primary key
  final String name;
  final double cost;
  final CurrencyType currencyName;
  final String note;
  final String ownerId;
  final DateTime time; // Proper DateTime type
  final ExpenseType expenseType;

  ExpenseArticle({
    required this.ownerId,
    this.id,
    required this.note,
    required this.time, // keep DateTime type
    required this.name,
    required this.cost,
    required this.currencyName,
    required this.expenseType,
  });

  @override
  List<Object?> get props => [
    id,
    note,
    time,
    name,
    cost,
    currencyName,
    ownerId,
    expenseType,
  ];
}

/// Used for Floor DB to convert DateTime <-> int (timestamp)
// class DateTimeConverter extends TypeConverter<DateTime, int> {
//   @override
//   DateTime decode(int databaseValue) {
//     return DateTime.fromMillisecondsSinceEpoch(databaseValue);
//   }
//
//   @override
//   int encode(DateTime value) {
//     return value.millisecondsSinceEpoch;
//   }
// }
