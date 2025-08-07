

import 'package:expense_tracker/features/domain/usecases/expenses/edit_expense.dart';
import 'package:expense_tracker/features/domain/usecases/expenses/save_expense.dart';
import 'package:expense_tracker/features/presentation/bloc/local_bloc_statement/local_expense_event.dart';
import 'package:expense_tracker/features/presentation/bloc/local_bloc_statement/local_expense_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/expenses/get_save_expense.dart';
import '../../../domain/usecases/expenses/remove_expense.dart';

class LocalExpenseBloc extends Bloc<LocalExpenseEvent, LocalExpenseState> {
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
    on<GetSavedExpense>(_onGetExpense);
    on<RemoveExpense>(_onRemovedExpense);
    on<InsertExpense>(_onInsertExpense);
    on<EditExpense>(_onEditedExpense);
    on<FilterExpenseByType>(_onFilterExpenseByType);
    on<GetFilterExpense>(_onFilterExpenseByOwner);
  }
  String? _currentOwnerId;

  void _onGetExpense(GetSavedExpense event, Emitter<LocalExpenseState> emit) async {
    final expenses = await _getSavedArticleUseCase();

  }
  void _onFilterExpenseByOwner(GetFilterExpense event, Emitter<LocalExpenseState> emit) async {
    _currentOwnerId = event.ownerId; // 🟡 Save it

    final allExpenses = await _getSavedArticleUseCase();

    print('🔍 Filtering for ownerId: ${event.ownerId}');
    for (var expense in allExpenses) {
      print(' Owner ID: ${expense.ownerId}');
    }

    final filtered = allExpenses.where((e) => e.ownerId == event.ownerId).toList();

    print('✅ Filtered ${filtered.length} expenses');
    emit(LocalExpenseDone(filtered));
  }



  void _onRemovedExpense(RemoveExpense event, Emitter<LocalExpenseState> emit) async {
    await _removeExpenseUseCase(params: event.expenseArticle);
    final allExpenses = await _getSavedArticleUseCase();

    final filtered = _currentOwnerId == null
        ? allExpenses
        : allExpenses.where((e) => e.ownerId == _currentOwnerId).toList();

    emit(LocalExpenseDone(filtered));
  }

  void _onInsertExpense(InsertExpense event, Emitter<LocalExpenseState> emit) async {
    await _saveExpenseUseCase(params: event.expenseArticle);
    final allExpenses = await _getSavedArticleUseCase();

    final filtered = _currentOwnerId == null
        ? allExpenses
        : allExpenses.where((e) => e.ownerId == _currentOwnerId).toList();

    emit(LocalExpenseDone(filtered));
  }



  void _onEditedExpense(EditExpense event, Emitter<LocalExpenseState> emit) async {
    await _editExpenseUseCase(params: event.expenseArticle);
    final allExpenses = await _getSavedArticleUseCase();

    final filtered = _currentOwnerId == null
        ? allExpenses
        : allExpenses.where((e) => e.ownerId == _currentOwnerId).toList();

    emit(LocalExpenseDone(filtered));
  }

  void _onFilterExpenseByType(FilterExpenseByType event, Emitter<LocalExpenseState> emit) async {
    if (state is LocalExpenseDone) {
      final currentExpenses = (state as LocalExpenseDone).expense;

      if (event.type == null) {
        emit(LocalExpenseDone(currentExpenses!)); // no filter, show current state as-is
      } else {
        final filtered = currentExpenses
            ?.where((e) => e.expenseType == event.type)
            .toList();

        emit(LocalExpenseDone(filtered!));
      }
    }
  }


}