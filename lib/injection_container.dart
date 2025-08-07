import 'package:expense_tracker/features/data/data_sources/local/local_expense_database.dart';
import 'package:expense_tracker/features/domain/usecases/expenses/edit_expense.dart';
import 'package:expense_tracker/features/domain/usecases/expenses/save_expense.dart';
import 'package:expense_tracker/features/presentation/bloc/local_bloc_statement/local_expense_event.dart';
import 'package:expense_tracker/features/presentation/bloc/local_bloc_statement/local_expnese_bloc.dart';
import 'package:get_it/get_it.dart';

import 'FireBase/FireBaseStore/fire_base_store_expense_service.dart';
import 'FireBase/FireBaseStore/fire_base_store_service.dart';
import 'features/data/data_repository/auth_repository.dart';
import 'features/data/data_repository/expense_repository_local.dart';
import 'features/domain/repository/auth_repository.dart';
import 'features/domain/repository/expense_repository.dart';
import 'features/domain/usecases/auth/edit_auth.dart';
import 'features/domain/usecases/auth/get_auth.dart';
import 'features/domain/usecases/auth/remove_expense.dart';
import 'features/domain/usecases/auth/save_expense.dart';
import 'features/domain/usecases/expenses/get_save_expense.dart';
import 'features/domain/usecases/expenses/remove_expense.dart';
import 'features/presentation/bloc/firebase_bloc_state_management/fire_base_cubit_state_management.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // //LocalDataBase
  // final database =
  //     await $FloorAppDataBase
  //         .databaseBuilder('local_expense_database.db')
  //         .build();
  // sl.registerSingleton<AppDataBase>(database);
  // Firebase Service
  sl.registerLazySingleton<FirebaseStoreService>(() => FirebaseStoreService());
  sl.registerLazySingleton<FirebaseStoreServiceExpense>(() => FirebaseStoreServiceExpense());
  sl.registerSingleton<ExpenseRepository>(ExpenseImplFireBase(sl()));
  //
  // //LocalBloc
  sl.registerFactory<LocalExpenseBloc>(
    () => LocalExpenseBloc(sl(), sl(), sl(), sl()),
  );
  //UseCases
  sl.registerSingleton<GetSavedArticleUseCase>(GetSavedArticleUseCase(sl()));
  sl.registerSingleton<RemoveExpenseUseCase>(RemoveExpenseUseCase(sl()));
  sl.registerSingleton<EditExpenseUseCase>(EditExpenseUseCase(sl()));
  sl.registerSingleton<SaveExpenseUseCase>(SaveExpenseUseCase(sl()));
  //firebase

// Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepoImplFireBase(sl())); // inject FirebaseStoreService
  //FireBaseBloc
  sl.registerFactory<FirebaseCubit>(
    () => FirebaseCubit(sl(),),
  );
// UseCases
  sl.registerSingleton<GetSavedAuthUseCase>(GetSavedAuthUseCase(sl()));
  sl.registerSingleton<SaveAuthUseCase>(SaveAuthUseCase(sl()));
  sl.registerSingleton<DeleteAuthUseCase>(DeleteAuthUseCase(sl()));
  sl.registerSingleton<EditAuthUseCase>(EditAuthUseCase(sl()));

}
