import 'package:expense_tracker_bloc/blocs/expense_bloc.dart';
import 'package:expense_tracker_bloc/blocs/expense_state.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryChart extends StatelessWidget {
  const CategoryChart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseBloc, ExpenseState>(
      builder: (context, state) {
        if (state.expenses.isEmpty) {
          return Container(
            height: 200,
            alignment: Alignment.center,
            child: const Text("No data to show"),
          );
        }
        return BarChart(BarChartData());
      },
    );
  }
}
