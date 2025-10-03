import 'package:expense_tracker_bloc/ui/widgets/add_expense_sheet.dart';
import 'package:expense_tracker_bloc/ui/widgets/expense_list.dart';
import 'package:expense_tracker_bloc/ui/widgets/total_expense.dart';
import 'package:flutter/material.dart';

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
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (_) => const AddExpenseSheet(),
              );
            },
            icon: const Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [
          // Bar Chart
          // CategoryChart(),
          // List of Expenses
          ExpenseList(),
          // Total Expenditure Amount
          TotalExpense(),
        ],
      ),
    );
  }
}
