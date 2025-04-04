import 'package:expense_tracker/features/data/data_sources/local/local_expense_database.dart';
import 'package:expense_tracker/features/domain/usecases/edit_expense.dart';
import 'package:expense_tracker/features/domain/usecases/get_save_expense.dart';
import 'package:expense_tracker/features/domain/usecases/remove_expense.dart';
import 'package:expense_tracker/features/domain/usecases/save_expense.dart';
import 'package:expense_tracker/features/presentation/bloc/local_bloc_statement/local_expense_event.dart';
import 'package:expense_tracker/features/presentation/bloc/local_bloc_statement/local_expnese_bloc.dart';
import 'package:get_it/get_it.dart';

import 'features/data/data_repository/expense_repository.dart';
import 'features/domain/repository/expense_repository.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  //LocalDataBase
  final database =
      await $FloorAppDataBase
          .databaseBuilder('local_expense_database.db')
          .build();
  sl.registerSingleton<AppDataBase>(database);
  sl.registerSingleton<ExpenseRepository>(ExpenseImpl(sl()));

  //LocalBloc
  sl.registerFactory<LocalExpenseBloc>(
    () => LocalExpenseBloc(sl(), sl(), sl(), sl()),
  );
  //UseCases
  sl.registerSingleton<GetSavedArticleUseCase>(GetSavedArticleUseCase(sl()));
  sl.registerSingleton<RemoveExpenseUseCase>(RemoveExpenseUseCase(sl()));
  sl.registerSingleton<EditExpenseUseCase>(EditExpenseUseCase(sl()));
  sl.registerSingleton<SaveExpenseUseCase>(SaveExpenseUseCase(sl()));
}
