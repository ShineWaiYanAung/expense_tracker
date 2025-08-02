

import 'package:expense_tracker/features/domain/usecases/edit_expense.dart';
import 'package:expense_tracker/features/domain/usecases/get_save_expense.dart';
import 'package:expense_tracker/features/domain/usecases/remove_expense.dart';
import 'package:expense_tracker/features/domain/usecases/save_expense.dart';
import 'package:expense_tracker/features/presentation/bloc/local_bloc_statement/local_expense_event.dart';
import 'package:expense_tracker/features/presentation/bloc/local_bloc_statement/local_expense_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocalExpenseBloc extends Bloc<LocalExpenseEvent, LocalExpenseState>{
  final GetSavedArticleUseCase _getSavedArticleUseCase;
  final SaveExpenseUseCase _saveExpenseUseCase;
  final RemoveExpenseUseCase _removeExpenseUseCase;
  final EditExpenseUseCase _editExpenseUseCase;
  LocalExpenseBloc(
      this._editExpenseUseCase,
      this._saveExpenseUseCase,
      this._getSavedArticleUseCase,
      this._removeExpenseUseCase,
      ) : super(const LocalExpenseLoading()) {
    on<GetSavedExpense>(onGetSavedExpense);
    on<RemoveExpense>(onRemovedExpense);
    on<InsertExpense>(onInsertExpense);
    on<EditExpense>(onEditedExpense);
    on<FilterExpenseByType>(_onFilterExpenseByType);
  }


  void onGetSavedExpense(GetSavedExpense event, Emitter<LocalExpenseState>emit)async{
    final expense = await _getSavedArticleUseCase();
    emit(LocalExpenseDone(expense));
  }
  void onRemovedExpense(RemoveExpense event, Emitter<LocalExpenseState>emit) async{
    await _removeExpenseUseCase(params: event.expenseArticle);
    final expenses = await _getSavedArticleUseCase();
    emit(LocalExpenseDone(expenses));
  }
  void onInsertExpense(InsertExpense event , Emitter<LocalExpenseState>emit)async{
    await _saveExpenseUseCase(params: event.expenseArticle);
    final expenses = await _getSavedArticleUseCase();
    emit(LocalExpenseDone(expenses));
}
  void onEditedExpense(EditExpense event , Emitter<LocalExpenseState>emit)async{
    await _editExpenseUseCase(params: event.expenseArticle);
    final expenses = await _getSavedArticleUseCase();
    emit(LocalExpenseDone(expenses));
  }
  void _onFilterExpenseByType(FilterExpenseByType event, Emitter<LocalExpenseState> emit) async {
    final allExpenses = await _getSavedArticleUseCase();

    if (event.type == null) {
      emit(LocalExpenseDone(allExpenses)); // no filter, show all
    } else {
      final filtered = allExpenses
          .where((e) => e.expenseType == event.type)
          .toList();

      emit(LocalExpenseDone(filtered));
    }
  }

}