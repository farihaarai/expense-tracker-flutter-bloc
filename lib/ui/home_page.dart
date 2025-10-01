import 'package:expense_tracker_bloc/blocs/expense_bloc.dart';
import 'package:expense_tracker_bloc/blocs/expense_event.dart';
import 'package:expense_tracker_bloc/enums/expense_category.dart';
import 'package:expense_tracker_bloc/models/expense.dart';
import 'package:expense_tracker_bloc/ui/widgets/expense_list.dart';
import 'package:expense_tracker_bloc/ui/widgets/total_expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker"),
        actions: [
          IconButton(
            onPressed: () {
              _showAddExpenseDialog(context);
            },
            icon: const Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [
          // List of Expenses
          ExpenseList(),
          // Total Expenditure Amount
          TotalExpense(),
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

    //  Add Expense Dailog
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
