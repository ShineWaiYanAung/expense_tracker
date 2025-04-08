import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';
import '../../../domain/entity/expense_article.dart';
import '../../model/expense_article_model.dart';
import 'dao/expense_local.dart';
part 'local_expense_database.g.dart';

@Database(version: 1, entities: [ExpenseArticleModel])
abstract class AppDataBase extends FloorDatabase {
  ExpenseDao get articleDAO;
}
