// expense_category_chart.dart
import 'package:expense_tracker_bloc/blocs/expense_bloc.dart';
import 'package:expense_tracker_bloc/blocs/expense_event.dart';
import 'package:expense_tracker_bloc/utils/category_totals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:expense_tracker_bloc/models/expense.dart';
import 'package:expense_tracker_bloc/models/category_total.dart';

class CategoryChart extends StatelessWidget {
  final List<Expense> expenses;

  const CategoryChart({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {
    final categoryTotals = getCategoryTotals(expenses);

    return SizedBox(
      height: 275,
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(
          labelRotation: 45,
          majorGridLines: const MajorGridLines(
            width: 0,
          ), // remove vertical grid lines
        ),
        primaryYAxis: NumericAxis(
          majorGridLines: const MajorGridLines(
            width: 0,
          ), // remove horizontal grid lines
        ),
        series: <CartesianSeries<CategoryTotal, String>>[
          ColumnSeries<CategoryTotal, String>(
            dataSource: categoryTotals,
            xValueMapper: (data, _) => data.category.name,
            yValueMapper: (data, _) => data.total,
            color: Colors.teal,
            pointColorMapper: (data, _) {
              final selectedCategory = context
                  .read<ExpenseBloc>()
                  .state
                  .selectedCategory;
              if (selectedCategory == null) return Colors.teal;
              return data.category == selectedCategory
                  ? Colors.teal
                  : Colors.teal.withOpacity(0.3);
            },
            dataLabelSettings: const DataLabelSettings(isVisible: true),
            onPointTap: (ChartPointDetails details) {
              final tappedCategory =
                  categoryTotals[details.pointIndex!].category;
              final bloc = context.read<ExpenseBloc>();

              if (bloc.state.selectedCategory == tappedCategory) {
                bloc.add(ClearFilter());
              } else {
                bloc.add(FilterByCategory(tappedCategory));
              }
            },
          ),
        ],
      ),
    );
  }
}
