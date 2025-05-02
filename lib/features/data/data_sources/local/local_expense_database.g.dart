// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_expense_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDataBaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDataBaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDataBaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDataBase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDataBase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDataBaseBuilderContract databaseBuilder(String name) =>
      _$AppDataBaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDataBaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDataBaseBuilder(null);
}

class _$AppDataBaseBuilder implements $AppDataBaseBuilderContract {
  _$AppDataBaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDataBaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDataBaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDataBase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDataBase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDataBase extends AppDataBase {
  _$AppDataBase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ExpenseDao? _articleDAOInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `expense` (`expenseType` INTEGER NOT NULL, `id` INTEGER, `name` TEXT NOT NULL, `cost` REAL NOT NULL, `currencyName` TEXT NOT NULL, `note` TEXT NOT NULL, `time` INTEGER NOT NULL, PRIMARY KEY (`time`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ExpenseDao get articleDAO {
    return _articleDAOInstance ??= _$ExpenseDao(database, changeListener);
  }
}

class _$ExpenseDao extends ExpenseDao {
  _$ExpenseDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _expenseArticleModelInsertionAdapter = InsertionAdapter(
            database,
            'expense',
            (ExpenseArticleModel item) => <String, Object?>{
                  'expenseType': item.expenseType.index,
                  'id': item.id,
                  'name': item.name,
                  'cost': item.cost,
                  'currencyName': item.currencyName,
                  'note': item.note,
                  'time': item.time
                }),
        _expenseArticleModelUpdateAdapter = UpdateAdapter(
            database,
            'expense',
            ['time'],
            (ExpenseArticleModel item) => <String, Object?>{
                  'expenseType': item.expenseType.index,
                  'id': item.id,
                  'name': item.name,
                  'cost': item.cost,
                  'currencyName': item.currencyName,
                  'note': item.note,
                  'time': item.time
                }),
        _expenseArticleModelDeletionAdapter = DeletionAdapter(
            database,
            'expense',
            ['time'],
            (ExpenseArticleModel item) => <String, Object?>{
                  'expenseType': item.expenseType.index,
                  'id': item.id,
                  'name': item.name,
                  'cost': item.cost,
                  'currencyName': item.currencyName,
                  'note': item.note,
                  'time': item.time
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ExpenseArticleModel>
      _expenseArticleModelInsertionAdapter;

  final UpdateAdapter<ExpenseArticleModel> _expenseArticleModelUpdateAdapter;

  final DeletionAdapter<ExpenseArticleModel>
      _expenseArticleModelDeletionAdapter;

  @override
  Future<List<ExpenseArticleModel>> getArticle() async {
    return _queryAdapter.queryList('SELECT * FROM expense',
        mapper: (Map<String, Object?> row) => ExpenseArticleModel(
            note: row['note'] as String,
            expenseType: ExpenseType.values[row['expenseType'] as int],
            time: _dateTimeConverter.decode(row['time'] as int),
            name: row['name'] as String,
            cost: row['cost'] as double,
            currencyName: row['currencyName'] as String));
  }

  @override
  Future<void> insertArticle(ExpenseArticleModel expense) async {
    await _expenseArticleModelInsertionAdapter.insert(
        expense, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateArticle(ExpenseArticleModel expense) async {
    await _expenseArticleModelUpdateAdapter.update(
        expense, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteArticle(ExpenseArticleModel expense) async {
    await _expenseArticleModelDeletionAdapter.delete(expense);
  }
}

// ignore_for_file: unused_element


final _dateTimeConverter = DateTimeConverter();
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
