import 'package:expense_tracker_bloc/blocs/expense_bloc.dart';
import 'package:expense_tracker_bloc/blocs/expense_event.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_bloc/enums/expense_category.dart';
import 'package:expense_tracker_bloc/models/expense.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class EditExpenseDialog extends StatefulWidget {
  final Expense expense;

  const EditExpenseDialog({super.key, required this.expense});

  @override
  State<EditExpenseDialog> createState() => _EditExpenseDialogState();
}

class _EditExpenseDialogState extends State<EditExpenseDialog> {
  final TextEditingController titleController = TextEditingController(text: "");
  final TextEditingController amountController = TextEditingController(
    text: "",
  );

  late ExpenseCategory selectedCategory;
  late DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    titleController.text = widget.expense.title;
    amountController.text = widget.expense.amount.toString();
    selectedCategory = widget.expense.category;
    selectedDate = widget.expense.date;
  }

  void presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: firstDate,
      lastDate: now,
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
        print(selectedDate);
      });
    }
  }

  void onSave() {
    final title = titleController.text.trim();
    final amount = double.tryParse(amountController.text) ?? 0.0;

    if (title.isEmpty || amount <= 0 || selectedDate == null) {
      // Show alert if input is invalid
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
    final updatedExpense = Expense(
      id: widget.expense.id,
      title: title,
      amount: amount,
      date: selectedDate!,
      category: selectedCategory,
    );

    bloc.add(EditExpense(updatedExpense));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    // print(selectedDate);
    return AlertDialog(
      title: const Text("Edit an Expense"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: "Title"),
          ),
          TextField(
            controller: amountController,
            decoration: const InputDecoration(labelText: "Amount"),
            keyboardType: TextInputType.number,
          ),
          DropdownButtonFormField(
            value: selectedCategory,
            items: ExpenseCategory.values
                .map((c) => DropdownMenuItem(value: c, child: Text(c.name)))
                .toList(),
            onChanged: (value) {
              if (value != null) selectedCategory = value;
            },
            decoration: const InputDecoration(labelText: "Category"),
          ),
          Row(
            children: [
              Text(
                selectedDate == null
                    ? "No Date Chosen"
                    : DateFormat('dd/MM/yyyy').format(selectedDate!),
              ),
              IconButton(
                onPressed: presentDatePicker,
                icon: const Icon(Icons.calendar_month),
              ),
            ],
          ),
        ],
      ),

      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel"),
        ),
        ElevatedButton(onPressed: onSave, child: Text("Save")),
      ],
    );
  }
}
