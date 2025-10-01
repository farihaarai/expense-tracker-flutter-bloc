// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ExpenseCWProxy {
  Expense id(int id);

  Expense title(String title);

  Expense amount(double amount);

  Expense date(DateTime date);

  Expense category(ExpenseCategory category);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Expense(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Expense(...).copyWith(id: 12, name: "My name")
  /// ```
  Expense call({
    int id,
    String title,
    double amount,
    DateTime date,
    ExpenseCategory category,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfExpense.copyWith(...)` or call `instanceOfExpense.copyWith.fieldName(value)` for a single field.
class _$ExpenseCWProxyImpl implements _$ExpenseCWProxy {
  const _$ExpenseCWProxyImpl(this._value);

  final Expense _value;

  @override
  Expense id(int id) => call(id: id);

  @override
  Expense title(String title) => call(title: title);

  @override
  Expense amount(double amount) => call(amount: amount);

  @override
  Expense date(DateTime date) => call(date: date);

  @override
  Expense category(ExpenseCategory category) => call(category: category);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Expense(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Expense(...).copyWith(id: 12, name: "My name")
  /// ```
  Expense call({
    Object? id = const $CopyWithPlaceholder(),
    Object? title = const $CopyWithPlaceholder(),
    Object? amount = const $CopyWithPlaceholder(),
    Object? date = const $CopyWithPlaceholder(),
    Object? category = const $CopyWithPlaceholder(),
  }) {
    return Expense(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int,
      title: title == const $CopyWithPlaceholder() || title == null
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String,
      amount: amount == const $CopyWithPlaceholder() || amount == null
          ? _value.amount
          // ignore: cast_nullable_to_non_nullable
          : amount as double,
      date: date == const $CopyWithPlaceholder() || date == null
          ? _value.date
          // ignore: cast_nullable_to_non_nullable
          : date as DateTime,
      category: category == const $CopyWithPlaceholder() || category == null
          ? _value.category
          // ignore: cast_nullable_to_non_nullable
          : category as ExpenseCategory,
    );
  }
}

extension $ExpenseCopyWith on Expense {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfExpense.copyWith(...)` or `instanceOfExpense.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ExpenseCWProxy get copyWith => _$ExpenseCWProxyImpl(this);
}
