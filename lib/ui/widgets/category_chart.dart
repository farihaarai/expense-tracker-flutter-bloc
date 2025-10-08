// expense_category_chart.dart
import 'package:expense_tracker_bloc/utils/category_totals.dart';
import 'package:flutter/material.dart';
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
        primaryXAxis: CategoryAxis(labelRotation: 45),
        // primaryYAxis: NumericAxis(title: AxisTitle(text: 'Amount Spent')),
        series: <CartesianSeries<CategoryTotal, String>>[
          ColumnSeries<CategoryTotal, String>(
            dataSource: categoryTotals,
            xValueMapper: (data, _) => data.category.name,
            yValueMapper: (data, _) => data.total,
            color: Colors.teal,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
          ),
        ],
      ),
    );
  }
}
