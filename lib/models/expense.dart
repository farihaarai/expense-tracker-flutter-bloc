import 'package:equatable/equatable.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:expense_tracker_bloc/enums/expense_category.dart';

part 'expense.g.dart';

@CopyWith()
class Expense extends Equatable {
  final int? id;
  final String title;
  final double amount;
  final DateTime date;
  final ExpenseCategory category;

  const Expense({
    this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'date': date.toIso8601String(),
      'category': category.name,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      title: map['title'],
      amount: map['amount'],
      date: DateTime.parse(map['date']),
      category: ExpenseCategory.values.firstWhere(
        (e) => e.name == map['category'],
      ),
    );
  }

  @override
  List<Object?> get props => [id, title, amount, date, category];
}
