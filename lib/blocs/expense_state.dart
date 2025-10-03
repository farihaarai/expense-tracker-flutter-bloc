import 'package:expense_tracker_bloc/models/category_total.dart';
import 'package:expense_tracker_bloc/models/expense.dart';
import 'package:equatable/equatable.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'expense_state.g.dart';

@CopyWith()
class ExpenseState extends Equatable {
  final List<Expense> expenses;
  final double totalAmount;
  final List<CategoryTotal> categoryTotals;

  const ExpenseState({
    this.expenses = const [],
    this.totalAmount = 0.0,
    this.categoryTotals = const [],
  });

  @override
  List<Object?> get props => [expenses, totalAmount, categoryTotals];
}
