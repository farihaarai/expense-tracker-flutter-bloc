import 'package:expense_tracker_bloc/blocs/expense_bloc.dart';
import 'package:expense_tracker_bloc/blocs/expense_event.dart';
import 'package:expense_tracker_bloc/blocs/expense_state.dart';
import 'package:expense_tracker_bloc/ui/widgets/edit_expense_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<ExpenseBloc, ExpenseState>(
      builder: (context, state) {
        if (state.expenses.isEmpty) {
          return Center(
            child: Text(
              "No expenses yet 💸\nTap 'Add Expense' to start tracking!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          itemCount: state.expenses.length,
          itemBuilder: (context, index) {
            final expense = state.expenses[index];

            return Dismissible(
              key: ValueKey(expense.id),
              background: Container(
                decoration: BoxDecoration(
                  color: colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 20),
                child: Icon(Icons.delete, color: colorScheme.onErrorContainer),
              ),
              secondaryBackground: Container(
                decoration: BoxDecoration(
                  color: colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                child: Icon(Icons.delete, color: colorScheme.onErrorContainer),
              ),
              onDismissed: (direction) {
                final bloc = context.read<ExpenseBloc>();
                final deletedExpense = expense;
                bloc.add(DeleteExpense(expense.id!));

                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Deleted '${deletedExpense.title}'"),
                    duration: const Duration(seconds: 3),
                    action: SnackBarAction(
                      label: "Undo",
                      onPressed: () {
                        bloc.add(AddExpense(deletedExpense));
                      },
                    ),
                  ),
                );
              },
              child: Card(
                margin: const EdgeInsets.symmetric(vertical: 6),
                elevation: 0,
                color: colorScheme.surfaceContainerLow,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: ListTile(
                  title: Text(
                    expense.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  subtitle: Text(
                    "${expense.category.name} • ${DateFormat('dd MMM yyyy').format(expense.date)}",
                    style: TextStyle(
                      color: colorScheme.onSurfaceVariant,
                      fontSize: 13,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "₹${expense.amount.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => EditExpenseDialog(expense: expense),
                          );
                        },
                        icon: Icon(Icons.edit, color: colorScheme.secondary),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
