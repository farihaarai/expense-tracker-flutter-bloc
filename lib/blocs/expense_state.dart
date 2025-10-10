import 'package:expense_tracker_bloc/enums/expense_category.dart';
import 'package:expense_tracker_bloc/models/category_total.dart';
import 'package:expense_tracker_bloc/models/expense.dart';
import 'package:equatable/equatable.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'expense_state.g.dart';

@CopyWith()
class ExpenseState extends Equatable {
  final List<Expense> expenses;
  final List<Expense> filteredExpenses;
  final double totalAmount;
  final List<CategoryTotal> categoryTotals;
  final ExpenseCategory? selectedCategory;

  const ExpenseState({
    this.expenses = const [],
    this.filteredExpenses = const [],
    this.totalAmount = 0.0,
    this.categoryTotals = const [],
    this.selectedCategory,
  });

  @override
  List<Object?> get props => [
    expenses,
    filteredExpenses,
    totalAmount,
    categoryTotals,
    selectedCategory,
  ];
}
