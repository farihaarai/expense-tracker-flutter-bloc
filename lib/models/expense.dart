import 'package:equatable/equatable.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:expense_tracker_bloc/enums/expense_category.dart';

part 'expense.g.dart';

@CopyWith()
class Expense extends Equatable {
  final int id;
  final String title;
  final double amount;
  final DateTime date;
  final ExpenseCategory category;

  const Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  });

  @override
  List<Object?> get props => [id, title, amount, date, category];
}
