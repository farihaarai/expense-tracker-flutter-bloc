import 'package:expense_tracker_bloc/blocs/expense_bloc.dart';
import 'package:expense_tracker_bloc/blocs/expense_event.dart';
import 'package:expense_tracker_bloc/ui/widgets/add_expense_sheet.dart';
// import 'package:expense_tracker_bloc/ui/widgets/category_chart.dart';
import 'package:expense_tracker_bloc/ui/widgets/expense_list.dart';
import 'package:expense_tracker_bloc/ui/widgets/total_expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ExpenseBloc>(context).add(LoadExpenses());
  }

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
          // Text("Test"),
          // ElevatedButton(
          //   onPressed: () {
          //     print("Button Pressed");
          //   },
          //   child: Text("Check DB 1"),
          // ),
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
