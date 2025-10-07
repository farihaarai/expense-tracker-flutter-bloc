import 'package:expense_tracker_bloc/enums/expense_category.dart';
import 'package:flutter/material.dart';

Color getCategoryColor(ExpenseCategory category) {
  switch (category) {
    case ExpenseCategory.Food:
      return Colors.orangeAccent.shade100; // warm & appetizing
    case ExpenseCategory.Transport:
      return Colors.lightBlueAccent.shade100; // clean & calm
    case ExpenseCategory.Shopping:
      return Colors.deepPurpleAccent.shade100; // energetic
    case ExpenseCategory.Bills:
      return Colors.redAccent.shade100; // attention-grabbing
    case ExpenseCategory.Health:
      return Colors.greenAccent.shade100; // fresh & positive
    case ExpenseCategory.Entertainment:
      return Colors.tealAccent.shade100; // fun & lively
    case ExpenseCategory.Education:
      return Colors.indigoAccent.shade100; // calm & intellectual
    case ExpenseCategory.Travel:
      return Colors.cyanAccent.shade100; // refreshing & airy
    case ExpenseCategory.Others:
      return Colors.grey.shade300; // neutral fallback
  }
}
