import 'package:expense_tracker_bloc/models/expense.dart';
import 'package:expense_tracker_bloc/models/category_total.dart';
import 'package:expense_tracker_bloc/enums/expense_category.dart';

List<CategoryTotal> getCategoryTotals(List<Expense> expenses) {
  // This will store total amount for each category
  Map<ExpenseCategory, double> totals = {};

  // Start all categories with 0
  for (var category in ExpenseCategory.values) {
    totals[category] = 0.0;
  }

  // Add each expense to its category total
  for (var expense in expenses) {
    totals[expense.category] = totals[expense.category]! + expense.amount;
  }

  // Make a list from the map to use in chart
  List<CategoryTotal> categoryTotals = [];

  for (var category in totals.keys) {
    categoryTotals.add(
      CategoryTotal(category: category, total: totals[category]!),
    );
  }

  return categoryTotals;
}
