import 'package:expense_tracker_bloc/blocs/expense_bloc.dart';
import 'package:expense_tracker_bloc/repositories/expense_repository.dart';
import 'package:expense_tracker_bloc/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseTracker extends StatelessWidget {
  const ExpenseTracker({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ExpenseBloc(ExpenseRepository()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.from(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo),
          useMaterial3: false,
        ),
        home: HomePage(),
      ),
    );
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   theme: ThemeData.from(
    //     colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo),
    //     useMaterial3: false,
    //   ),
    //   home: BlocProvider(create: (_) => ExpenseBloc(), child: HomePage()),
    //   // home: HomePage(),
    // );
  }
}
