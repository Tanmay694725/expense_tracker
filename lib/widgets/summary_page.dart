import 'dart:ffi';

import 'package:expense_tracker/widgets/expenses_list/expenses_item.dart';
import 'package:flutter/material.dart';

import '../models/expense.dart';

class SummaryPage extends StatelessWidget {
  SummaryPage(this.category, this.expenses, {super.key})
      : filteredExpenses =
            expenses.where((element) => element.category == category).toList();

  final Category category;
  final List<Expense> expenses;
  final List<Expense> filteredExpenses;

  double findTotal() {
    double total = 0;
    for (Expense expense in filteredExpenses) {
      total += expense.amount;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.name.toUpperCase()),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Total Cost: \$${findTotal().toStringAsFixed(2)}'),
              Text(
                  'Average Expense Cost: \$${(findTotal() / filteredExpenses.length).toStringAsFixed(2)}')
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredExpenses.length,
              itemBuilder: (context, index) {
                return ExpenseItem(filteredExpenses[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
