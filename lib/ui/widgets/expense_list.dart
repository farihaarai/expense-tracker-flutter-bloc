import 'package:expense_tracker_bloc/blocs/expense_bloc.dart';
import 'package:expense_tracker_bloc/blocs/expense_event.dart';
import 'package:expense_tracker_bloc/blocs/expense_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<ExpenseBloc, ExpenseState>(
        builder: (context, state) {
          if (state.expenses.isEmpty) {
            return const Center(
              child: Text("No expenses found!! Start Adding Some..."),
            );
          }
          return ListView.builder(
            itemCount: state.expenses.length,
            itemBuilder: (context, index) {
              final expense = state.expenses[index];
              return Dismissible(
                key: ValueKey(expense),
                background: Container(color: Colors.red[300]),
                onDismissed: (direction) {
                  final bloc = context.read<ExpenseBloc>();
                  bloc.add(DeleteExpense(expense.id));
                },
                child: Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),

                  child: ListTile(
                    title: Text(expense.title),
                    subtitle: Text(expense.category.toString().split('.').last),
                    trailing: Text("\$${expense.amount.toStringAsFixed(2)}"),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
