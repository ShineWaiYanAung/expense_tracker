import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/features/data/model/expense_article_model.dart';

import '../../features/domain/entity/expense_article.dart';


class FirebaseStoreServiceExpense {
  final _expenseCollection = FirebaseFirestore.instance.collection('expenses');
  Future<void> addExpense(ExpenseArticle expense) async {
    final model = ExpenseArticleModel.fromEntity(expense);
    await _expenseCollection.add(model.toMap());
  }


  Future<void> updateExpense(ExpenseArticle expense) async {
    final query = await _expenseCollection
        .where('id', isEqualTo: expense.id)
        .limit(1)
        .get();

    if (query.docs.isNotEmpty) {
      await _expenseCollection.doc(query.docs.first.id).update({
        'note': expense.note,
        'time': expense.time,
        'name': expense.name,
        'cost': expense.cost,
        'currencyName': expense.currencyName,
        'expenseType': expense.expenseType.name,
      });
    }
  }

  Future<void> deleteExpense(ExpenseArticle expense) async {
    final query = await _expenseCollection
        .where('id', isEqualTo: expense.id)
        .limit(1)
        .get();

    if (query.docs.isNotEmpty) {
      await _expenseCollection.doc(query.docs.first.id).delete();
    }
  }

  Future<List<ExpenseArticle>> fetchExpenses() async {
    final snapshot = await _expenseCollection.get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      final String id = doc.id;

      // Print name and cost
      print('name: ${data['name']}');
      print('cost: ${data['cost']}');

      return ExpenseArticleModel.fromMap(data, id);
    }).toList();
  }


}
