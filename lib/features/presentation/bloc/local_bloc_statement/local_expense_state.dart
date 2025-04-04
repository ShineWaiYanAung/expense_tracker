import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entity/expense_article.dart';

abstract class LocalExpenseState extends Equatable {
  final List<ExpenseArticle>? expense;
  const LocalExpenseState({this.expense});

  @override
  List<Object> get props => [expense!];
}

class LocalExpenseLoading extends LocalExpenseState {
  const LocalExpenseLoading();
}

class LocalExpenseDone extends LocalExpenseState {
  const LocalExpenseDone(List<ExpenseArticle> expense)
    : super(expense: expense);
}
