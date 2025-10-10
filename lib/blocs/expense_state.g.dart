// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ExpenseStateCWProxy {
  ExpenseState expenses(List<Expense> expenses);

  ExpenseState filteredExpenses(List<Expense> filteredExpenses);

  ExpenseState totalAmount(double totalAmount);

  ExpenseState categoryTotals(List<CategoryTotal> categoryTotals);

  ExpenseState selectedCategory(ExpenseCategory? selectedCategory);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ExpenseState(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ExpenseState(...).copyWith(id: 12, name: "My name")
  /// ```
  ExpenseState call({
    List<Expense> expenses,
    List<Expense> filteredExpenses,
    double totalAmount,
    List<CategoryTotal> categoryTotals,
    ExpenseCategory? selectedCategory,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfExpenseState.copyWith(...)` or call `instanceOfExpenseState.copyWith.fieldName(value)` for a single field.
class _$ExpenseStateCWProxyImpl implements _$ExpenseStateCWProxy {
  const _$ExpenseStateCWProxyImpl(this._value);

  final ExpenseState _value;

  @override
  ExpenseState expenses(List<Expense> expenses) => call(expenses: expenses);

  @override
  ExpenseState filteredExpenses(List<Expense> filteredExpenses) =>
      call(filteredExpenses: filteredExpenses);

  @override
  ExpenseState totalAmount(double totalAmount) =>
      call(totalAmount: totalAmount);

  @override
  ExpenseState categoryTotals(List<CategoryTotal> categoryTotals) =>
      call(categoryTotals: categoryTotals);

  @override
  ExpenseState selectedCategory(ExpenseCategory? selectedCategory) =>
      call(selectedCategory: selectedCategory);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ExpenseState(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ExpenseState(...).copyWith(id: 12, name: "My name")
  /// ```
  ExpenseState call({
    Object? expenses = const $CopyWithPlaceholder(),
    Object? filteredExpenses = const $CopyWithPlaceholder(),
    Object? totalAmount = const $CopyWithPlaceholder(),
    Object? categoryTotals = const $CopyWithPlaceholder(),
    Object? selectedCategory = const $CopyWithPlaceholder(),
  }) {
    return ExpenseState(
      expenses: expenses == const $CopyWithPlaceholder() || expenses == null
          ? _value.expenses
          // ignore: cast_nullable_to_non_nullable
          : expenses as List<Expense>,
      filteredExpenses:
          filteredExpenses == const $CopyWithPlaceholder() ||
              filteredExpenses == null
          ? _value.filteredExpenses
          // ignore: cast_nullable_to_non_nullable
          : filteredExpenses as List<Expense>,
      totalAmount:
          totalAmount == const $CopyWithPlaceholder() || totalAmount == null
          ? _value.totalAmount
          // ignore: cast_nullable_to_non_nullable
          : totalAmount as double,
      categoryTotals:
          categoryTotals == const $CopyWithPlaceholder() ||
              categoryTotals == null
          ? _value.categoryTotals
          // ignore: cast_nullable_to_non_nullable
          : categoryTotals as List<CategoryTotal>,
      selectedCategory: selectedCategory == const $CopyWithPlaceholder()
          ? _value.selectedCategory
          // ignore: cast_nullable_to_non_nullable
          : selectedCategory as ExpenseCategory?,
    );
  }
}

extension $ExpenseStateCopyWith on ExpenseState {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfExpenseState.copyWith(...)` or `instanceOfExpenseState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ExpenseStateCWProxy get copyWith => _$ExpenseStateCWProxyImpl(this);
}
