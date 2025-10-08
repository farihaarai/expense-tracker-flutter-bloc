import 'package:expense_tracker_bloc/blocs/expense_bloc.dart';
import 'package:expense_tracker_bloc/blocs/expense_event.dart';
import 'package:expense_tracker_bloc/ui/widgets/add_expense_sheet.dart';
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

  void _openAddExpenseSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => const AddExpenseSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: const Text(
          "Expense Tracker",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 1,
        surfaceTintColor: theme.colorScheme.surfaceTint,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: theme.colorScheme.primaryContainer,
        foregroundColor: theme.colorScheme.onPrimaryContainer,
        onPressed: _openAddExpenseSheet,
        label: const Text("Add Expense"),
        icon: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // total expense card
              Card(
                elevation: 1,
                color: theme.colorScheme.surfaceContainerHighest,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: TotalExpense(),
                ),
              ),

              const SizedBox(height: 16),
              // Category Chart (updates automatically via BlocBuilder)
              // BlocBuilder<ExpenseBloc, ExpenseState>(
              //   builder: (context, state) {
              //     return CategoryChart(categoryTotals: state.categoryTotals);
              //   },
              // ),
              // const SizedBox(height: 16),
              // Expense list
              Expanded(
                child: Card(
                  elevation: 1,
                  color: theme.colorScheme.surfaceContainerHigh,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: ExpenseList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
