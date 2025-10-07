import 'package:expense_tracker_bloc/app.dart';
import 'package:expense_tracker_bloc/services/db_helper.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  print("Main");

  // Initialize your database
  await DbHelper.instance.initDatabase();
  print("DB Loaded");

  runApp(ExpenseTracker());
}
