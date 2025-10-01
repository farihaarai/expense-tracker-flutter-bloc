import 'package:equatable/equatable.dart';
import 'package:expense_tracker_bloc/models/expense.dart';

abstract class ExpenseEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadExpenses extends ExpenseEvent {
  LoadExpenses();

  @override
  List<Object?> get props => [];
}

class AddExpense extends ExpenseEvent {
  final Expense expense;

  AddExpense(this.expense);

  @override
  List<Object?> get props => [expense];
}

class DeleteExpense extends ExpenseEvent {
  final int id;

  DeleteExpense(this.id);

  @override
  List<Object?> get props => [id];
}
