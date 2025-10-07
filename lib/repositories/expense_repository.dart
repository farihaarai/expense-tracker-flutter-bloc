import 'package:expense_tracker_bloc/models/expense.dart';
import 'package:expense_tracker_bloc/services/db_helper.dart';

class ExpenseRepository {
  final DbHelper _dbHelper = DbHelper.instance;

  Future<List<Expense>> getAllExpenses() async {
    final expenses = await _dbHelper.getAllExpenses();
    return expenses.map((expense) => Expense.fromMap(expense)).toList();
  }

  Future<int> addExpense(Expense expense) async {
    return await _dbHelper.insertExpense(expense.toMap());
  }

  Future<int> updateExpense(Expense expense) async {
    return await _dbHelper.updateExpense(expense.toMap());
  }

  Future<int> deleteExpense(int id) async {
    return await _dbHelper.deleteExpense(id);
  }
}
