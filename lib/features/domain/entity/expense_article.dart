import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
enum ExpenseType {
   Bill,
   Food,
   Transport
}
@TypeConverters([DateTimeConverter]) // Apply the converter
@Entity(tableName: 'expenses')
class ExpenseArticle extends Equatable {
  @PrimaryKey(autoGenerate: true)
  final ExpenseType expenseType;
  final int? id; // Add ID as a primary key
  final String name;
  final double cost;
  final String currencyName;
  final double quantity;
  final double netPrice;

  @ColumnInfo(name: 'time')
  final int time; // Store DateTime as int (timestamp)

  ExpenseArticle( {
    required this.expenseType,
    this.id,
    required DateTime time, // Accept DateTime
    required this.name,
    required this.cost,
    required this.currencyName,
    required this.quantity,
    required this.netPrice,
  }) : time = time.millisecondsSinceEpoch; // Convert DateTime to int

  /// Convert back to DateTime when needed
  DateTime get dateTime => DateTime.fromMillisecondsSinceEpoch(time);

  @override
  List<Object?> get props => [
    id,
    dateTime, // Use the getter to return DateTime
    name,
    cost,
    currencyName,
    quantity,
    netPrice,
    expenseType
  ];
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
