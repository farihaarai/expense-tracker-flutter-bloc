import 'package:expense_tracker_bloc/blocs/expense_event.dart';
import 'package:expense_tracker_bloc/blocs/expense_state.dart';
import 'package:expense_tracker_bloc/enums/expense_category.dart';
import 'package:expense_tracker_bloc/models/expense.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  ExpenseBloc()
    : super(
        ExpenseState(
          expenses: [
            Expense(
              id: 1,
              title: "Coffee",
              amount: 4.5,
              date: DateTime.now(),
              category: ExpenseCategory.food,
            ),
            Expense(
              id: 2,
              title: "Bus Ticket",
              amount: 2.0,
              date: DateTime.now(),
              category: ExpenseCategory.travel,
            ),
            Expense(
              id: 3,
              title: "Movie",
              amount: 10.0,
              date: DateTime.now(),
              category: ExpenseCategory.entertainment,
            ),
          ],
          totalAmount: 16.5,
          categoryTotals: {"Food": 4.5, "Travel": 2.0, "Entertainment": 10.0},
        ),
      ) {
    on<LoadExpenses>(_onLoadExpensesEvent);
    on<AddExpense>(_onAddExpenseEvent);
    on<DeleteExpense>(_onDeleteExpenseEvent);
  }

  void _onLoadExpensesEvent(LoadExpenses event, Emitter<ExpenseState> emit) {}

  void _onAddExpenseEvent(AddExpense event, Emitter<ExpenseState> emit) {
    // Way 1
    List<Expense> list = state.expenses; // existing state expenses
    list.add(event.expense); // add

    // Way 2
    // creating new list from existing list
    // List<Expense> newList = [...state.expenses, event.expense];

    // emit new state
    emit(
      state.copyWith(
        expenses: list,
        totalAmount: state.totalAmount + event.expense.amount,
      ),
    );
  }

  void _onDeleteExpenseEvent(DeleteExpense event, Emitter<ExpenseState> emit) {
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
}
