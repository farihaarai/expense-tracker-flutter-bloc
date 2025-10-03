import 'package:equatable/equatable.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:expense_tracker_bloc/enums/expense_category.dart';

part 'category_total.g.dart';

@CopyWith()
class CategoryTotal extends Equatable {
  final ExpenseCategory category;
  final double total;

  const CategoryTotal({required this.category, required this.total});

  @override
  List<Object?> get props => [category, total];
}
