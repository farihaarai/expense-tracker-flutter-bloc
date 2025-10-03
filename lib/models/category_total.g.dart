// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_total.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CategoryTotalCWProxy {
  CategoryTotal category(ExpenseCategory category);

  CategoryTotal total(double total);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `CategoryTotal(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CategoryTotal(...).copyWith(id: 12, name: "My name")
  /// ```
  CategoryTotal call({ExpenseCategory category, double total});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfCategoryTotal.copyWith(...)` or call `instanceOfCategoryTotal.copyWith.fieldName(value)` for a single field.
class _$CategoryTotalCWProxyImpl implements _$CategoryTotalCWProxy {
  const _$CategoryTotalCWProxyImpl(this._value);

  final CategoryTotal _value;

  @override
  CategoryTotal category(ExpenseCategory category) => call(category: category);

  @override
  CategoryTotal total(double total) => call(total: total);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `CategoryTotal(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CategoryTotal(...).copyWith(id: 12, name: "My name")
  /// ```
  CategoryTotal call({
    Object? category = const $CopyWithPlaceholder(),
    Object? total = const $CopyWithPlaceholder(),
  }) {
    return CategoryTotal(
      category: category == const $CopyWithPlaceholder() || category == null
          ? _value.category
          // ignore: cast_nullable_to_non_nullable
          : category as ExpenseCategory,
      total: total == const $CopyWithPlaceholder() || total == null
          ? _value.total
          // ignore: cast_nullable_to_non_nullable
          : total as double,
    );
  }
}

extension $CategoryTotalCopyWith on CategoryTotal {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfCategoryTotal.copyWith(...)` or `instanceOfCategoryTotal.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CategoryTotalCWProxy get copyWith => _$CategoryTotalCWProxyImpl(this);
}
