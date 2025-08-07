import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entity/auth_article.dart';
import '../../domain/entity/expense_article.dart';


class ExpenseArticleModel extends ExpenseArticle {
  ExpenseArticleModel({
    required super.id,
    required super.ownerId,
    required super.note,
    required super.expenseType,
    required super.time,
    required super.name,
    required super.cost,
    required super.currencyName,
    // required super.quantity,
    // required super.netPrice,
  });

  /// Factory method to create from Entity
  factory ExpenseArticleModel.fromEntity(ExpenseArticle entity) {
    return ExpenseArticleModel(
      id: entity.id,
      ownerId: entity.ownerId,
      note: entity.note,
      expenseType: entity.expenseType,
      time: entity.time,
      name: entity.name,
      cost: entity.cost,
      currencyName: entity.currencyName,
    );
  }


  factory ExpenseArticleModel.fromMap(Map<String, dynamic> map, String id) {
    return ExpenseArticleModel(
      id: id,
      name: map['name'],
      cost: (map['cost'] as num).toDouble(),
      note: map['note'],
      time: map['time'] != null
          ? (map['time'] as Timestamp).toDate()
          : DateTime.now(),
      currencyName: CurrencyType.values.firstWhere(
            (e) => e.name == map['currency'],
        orElse: () => CurrencyType.uk,
      ),
      expenseType: ExpenseType.values.firstWhere((e) => e.name == map['expenseType'],),
      ownerId: map['ownerId'],
    );
  }
  /// Convert model to Firebase-compatible Map
  Map<String, dynamic> toMap() {
    return {
      'ownerId': ownerId,
      'name': name,
      'cost': cost,
      'note': note,
      'time': time,
      'expenseType': expenseType.name,
      'currencyName': currencyName.name,
    };
  }
}
