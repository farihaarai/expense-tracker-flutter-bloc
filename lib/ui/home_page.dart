import 'package:expense_tracker_bloc/blocs/expense_bloc.dart';
import 'package:expense_tracker_bloc/blocs/expense_event.dart';
import 'package:expense_tracker_bloc/blocs/expense_state.dart';
import 'package:expense_tracker_bloc/enums/expense_category.dart';
import 'package:expense_tracker_bloc/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Expense Tracker")),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ExpenseBloc, ExpenseState>(
              builder: (context, state) {
                if (state.expenses.isEmpty) {
                  return const Center(child: Text("No expenses yet"));
                }
                return ListView.builder(
                  itemCount: state.expenses.length,
                  itemBuilder: (context, index) {
                    final expense = state.expenses[index];
                    return ListTile(
                      title: Text(expense.title),
                      subtitle: Text(
                        expense.category.toString().split('.').last,
                      ),
                      trailing: Text("\$${expense.amount.toStringAsFixed(2)}"),
                      // IconButton(
                      //   onPressed: () {},
                      //   icon: Icon(Icons.delete),
                      // ),
                    );
                  },
                );
              },
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              _showAddExpenseDialog(context);
            },
            child: const Icon(Icons.add),
          ),

          // Total Section
          BlocBuilder<ExpenseBloc, ExpenseState>(
            builder: (context, state) {
              return Container(
                padding: EdgeInsets.all(16),
                color: Colors.grey[200],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total: ",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "\$${state.totalAmount.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showAddExpenseDialog(BuildContext context) {
    final titleController = TextEditingController();
    final amountController = TextEditingController();
    ExpenseCategory selectedCategory = ExpenseCategory.food;
    void onSave() {
      final title = titleController.text.trim();
      final amount = double.tryParse(amountController.text) ?? 0.0;

      if (title.isNotEmpty && amount > 0) {
        final bloc = context.read<ExpenseBloc>();
        final newId = bloc.state.expenses.isEmpty
            ? 1
            : bloc.state.expenses
                      .map((e) => e.id)
                      .reduce((a, b) => a > b ? a : b) +
                  1;
        final newExpense = Expense(
          id: newId,
          title: title,
          amount: amount,
          date: DateTime.now(),
          category: selectedCategory,
        );

        bloc.add(AddExpense(newExpense));
        Navigator.pop(context);
      }
    }

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Add Expense"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: "Title"),
              ),
              TextField(
                controller: amountController,
                decoration: const InputDecoration(labelText: "Amount"),
                keyboardType: TextInputType.number,
              ),
              DropdownButtonFormField(
                value: selectedCategory,
                items: ExpenseCategory.values
                    .map((c) => DropdownMenuItem(value: c, child: Text(c.name)))
                    .toList(),
                onChanged: (value) {
                  if (value != null) selectedCategory = value;
                },
                decoration: const InputDecoration(labelText: "Category"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            ElevatedButton(onPressed: onSave, child: Text("Save")),
          ],
        );
      },
    );
  }
}
