import 'package:expense_tracker_bloc/blocs/expense_bloc.dart';
import 'package:expense_tracker_bloc/blocs/expense_event.dart';
import 'package:expense_tracker_bloc/blocs/expense_state.dart';
import 'package:expense_tracker_bloc/ui/widgets/edit_expense_dialog.dart';
import 'package:expense_tracker_bloc/utils/category_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseList extends StatefulWidget {
  const ExpenseList({super.key});

  @override
  State<ExpenseList> createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
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
                  final deletedExpense = expense;
                  bloc.add(DeleteExpense(expense.id));

                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Deleted ${deletedExpense.title}"),

                      duration: Duration(seconds: 3),
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
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),

                  // color: getCategoryColor(expense.category),
                  child: ListTile(
                    title: Text(expense.title),
                    subtitle: Text(expense.category.toString().split('.').last),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("₹${expense.amount.toStringAsFixed(2)}"),
                        SizedBox(width: 10),
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) =>
                                  EditExpenseDialog(expense: expense),
                            );
                          },
                          icon: Icon(Icons.edit),
                        ),
                      ],
                    ),
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
