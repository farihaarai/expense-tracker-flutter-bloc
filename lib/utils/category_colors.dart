import 'package:expense_tracker_bloc/enums/expense_category.dart';
import 'package:flutter/material.dart';

Color getCategoryColor(ExpenseCategory category) {
  switch (category) {
    case ExpenseCategory.Food:
      return Colors.orange.shade200;
    case ExpenseCategory.Transport:
      return Colors.blueGrey.shade200;
    case ExpenseCategory.Shopping:
      return Colors.purple.shade200;
    case ExpenseCategory.Bills:
      return Colors.red.shade200;
    case ExpenseCategory.Health:
      return Colors.green.shade200;
    case ExpenseCategory.Entertainment:
      return Colors.pink.shade200;
    case ExpenseCategory.Education:
      return Colors.indigo.shade200;
    case ExpenseCategory.Travel:
      return Colors.teal.shade200;
    case ExpenseCategory.Others:
      return Colors.grey.shade300;
  }
}
