import 'package:expense_tracker/widgets/flowchart/expense_chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:intl/intl.dart';

class ExpenseChart extends StatelessWidget {
  final List<Expense> expenses;
  const ExpenseChart({super.key, required this.expenses,});

    

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalSum = 0;

      for (var i = 0; i < expenses.length; i++) {
        if (expenses[i].date.day == weekDay.day &&
            expenses[i].date.month == weekDay.month &&
            expenses[i].date.year == weekDay.year) {
          totalSum += expenses[i].amount;
        }
      }
      if (expenses.isNotEmpty) {
        return {
          'day': DateFormat.E().format(weekDay).substring(0, 1),
          'amount': totalSum,
        };
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (expenses.isNotEmpty) {
      return Card(
          elevation: 6,
          margin: const EdgeInsets.all(20),
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: groupedTransactionValues.map((data) {
                return Flexible(
                  fit: FlexFit.tight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ExpenseChartBar(
                      label: data['day'].toString(),
                      spendingAmount: data['amount'] as double,
                      spendingPctofTotal: totalSpending == 0.0
                          ? 0.0
                          : (data['amount'] as double) / totalSpending,
                    ),
                  ),
                );
              }).toList(),
            ),
          ));
    }
    return Card(
        elevation: 6,
        margin: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionValues.map((data) {
              return Flexible(
                fit: FlexFit.tight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ExpenseChartBar(
                    label: data['day'].toString(),
                    spendingAmount: data['amount'] as double,
                    spendingPctofTotal: totalSpending == 0.0
                        ? 0.0
                        : (data['amount'] as double) / totalSpending,
                  ),
                ),
              );
            }).toList(),
          ),
        ));
  }
}