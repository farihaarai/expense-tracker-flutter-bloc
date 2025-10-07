import 'package:expense_tracker_bloc/blocs/expense_bloc.dart';
import 'package:expense_tracker_bloc/blocs/expense_event.dart';
import 'package:expense_tracker_bloc/blocs/expense_state.dart';
import 'package:expense_tracker_bloc/enums/expense_category.dart';
import 'package:expense_tracker_bloc/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddExpenseSheet extends StatefulWidget {
  const AddExpenseSheet({super.key});

  @override
  State<AddExpenseSheet> createState() => _AddExpenseSheetState();
}

class _AddExpenseSheetState extends State<AddExpenseSheet> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  ExpenseCategory selectedCategory = ExpenseCategory.Food;
  DateTime? selectedDate;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  void onSave() {
    final title = titleController.text.trim();
    final amount = double.tryParse(amountController.text) ?? 0.0;

    if (title.isEmpty || amount <= 0 || selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Invalid Input"),
          content: const Text(
            "Please enter a valid title, amount, and select a date.",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text("OK"),
            ),
          ],
        ),
      );
      return;
    }

    final bloc = context.read<ExpenseBloc>();
    final newExpense = Expense(
      title: title,
      amount: amount,
      date: selectedDate!,
      category: selectedCategory,
    );

    bloc.add(AddExpense(newExpense));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<ExpenseBloc, ExpenseState>(
      builder: (context, state) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              Center(
                child: Text(
                  "Add Expense",
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Title field
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: "Title",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              // Amount field
              TextField(
                controller: amountController,
                decoration: const InputDecoration(
                  labelText: "Amount",
                  border: OutlineInputBorder(),
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),
              const SizedBox(height: 12),

              // Category and Date
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: DropdownButtonFormField(
                      value: selectedCategory,
                      items: ExpenseCategory.values
                          .map(
                            (c) =>
                                DropdownMenuItem(value: c, child: Text(c.name)),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => selectedCategory = value);
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: "Category",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: _presentDatePicker,
                      borderRadius: BorderRadius.circular(8),
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: "Date",
                          border: OutlineInputBorder(),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              selectedDate == null
                                  ? "Select"
                                  : DateFormat(
                                      'dd/MM/yyyy',
                                    ).format(selectedDate!),
                              style: TextStyle(
                                color: selectedDate == null
                                    ? Colors.grey.shade600
                                    : theme.textTheme.bodyMedium?.color,
                              ),
                            ),
                            const Icon(Icons.calendar_today, size: 18),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel"),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: onSave,
                    icon: const Icon(Icons.save_outlined),
                    label: const Text("Save"),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
