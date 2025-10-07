// import 'package:copy_with_extension_gen/builder.dart';
import 'package:expense_tracker_bloc/blocs/expense_event.dart';
import 'package:expense_tracker_bloc/blocs/expense_state.dart';
import 'package:expense_tracker_bloc/models/expense.dart';
// import 'package:expense_tracker_bloc/enums/expense_category.dart';
// import 'package:expense_tracker_bloc/models/expense.dart';
import 'package:expense_tracker_bloc/repositories/expense_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final ExpenseRepository _repository;

  ExpenseBloc(this._repository) : super(ExpenseState()) {
    on<LoadExpenses>(_onLoadExpensesEvent);
    on<AddExpense>(_onAddExpenseEvent);
    on<DeleteExpense>(_onDeleteExpenseEvent);
    on<EditExpense>(_onEditExpenseEvent);
  }

  Future<void> _onLoadExpensesEvent(
    LoadExpenses event,
    Emitter<ExpenseState> emit,
  ) async {
    print("Loading Expenses");
    final expenses = await _repository.getAllExpenses();
    double totalAmount = 0.0;
    for (var e in expenses) {
      totalAmount += e.amount;
    }
    emit(state.copyWith(expenses: expenses, totalAmount: totalAmount));
  }

  Future<void> _onAddExpenseEvent(
    AddExpense event,
    Emitter<ExpenseState> emit,
  ) async {
    await _repository.addExpense(event.expense);
    List<Expense> newList = [...state.expenses, event.expense];

    // emit new state
    emit(
      state.copyWith(
        expenses: newList,
        totalAmount: state.totalAmount + event.expense.amount,
      ),
    );
  }

  // void _onAddExpenseEvent(AddExpense event, Emitter<ExpenseState> emit) {
  //   // Way 1
  //   // List<Expense> list = state.expenses; // existing state expenses
  //   // list.add(event.expense); // add

  //   // Way 2
  //   // creating new list from existing list
  //   List<Expense> newList = [...state.expenses, event.expense];

  //   // emit new state
  //   emit(
  //     state.copyWith(
  //       expenses: newList,
  //       totalAmount: state.totalAmount + event.expense.amount,
  //     ),
  //   );
  // }

  Future<void> _onDeleteExpenseEvent(
    DeleteExpense event,
    Emitter<ExpenseState> emit,
  ) async {
    await _repository.deleteExpense(event.id);
    List<Expense> list = state.expenses;
    final expenseToDelete = list.firstWhere((e) => e.id == event.id);
    list.removeWhere((e) => e.id == event.id);

    emit(
      state.copyWith(
        expenses: list,
        totalAmount: state.totalAmount - expenseToDelete.amount,
      ),
    );
  }

  // void _onDeleteExpenseEvent(DeleteExpense event, Emitter<ExpenseState> emit) {
  //   List<Expense> list = state.expenses;
  //   final expenseToDelete = list.firstWhere((e) => e.id == event.id);
  //   list.removeWhere((e) => e.id == event.id);

  //   emit(
  //     state.copyWith(
  //       expenses: list,
  //       totalAmount: state.totalAmount - expenseToDelete.amount,
  //     ),
  //   );
  // }

  Future<void> _onEditExpenseEvent(
    EditExpense event,
    Emitter<ExpenseState> emit,
  ) async {
    await _repository.updateExpense(event.expense);
    final oldExpense = state.expenses.firstWhere(
      (e) => e.id == event.expense.id,
    );
    final updatedList = state.expenses.map((expense) {
      if (expense.id == event.expense.id) {
        return event.expense;
      }
      return expense;
    }).toList();
    final updatedTotal =
        state.totalAmount - oldExpense.amount + event.expense.amount;

    emit(state.copyWith(expenses: updatedList, totalAmount: updatedTotal));
  }

  // void _onEditExpenseEvent(EditExpense event, Emitter<ExpenseState> emit) {
  //   final oldExpense = state.expenses.firstWhere(
  //     (e) => e.id == event.expense.id,
  //   );
  //   final updatedList = state.expenses.map((expense) {
  //     if (expense.id == event.expense.id) {
  //       return event.expense;
  //     }
  //     return expense;
  //   }).toList();
  //   final updatedTotal =
  //       state.totalAmount - oldExpense.amount + event.expense.amount;

  //   emit(state.copyWith(expenses: updatedList, totalAmount: updatedTotal));
  // }
}
