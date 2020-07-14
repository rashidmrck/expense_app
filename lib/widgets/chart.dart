import 'package:expense_app/model/expense.dart';
import 'package:expense_app/widgets/chart_Bars.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Expense> recentTransaction;

  Chart({this.recentTransaction});

  List<Map<String, Object>> get groupedTransactionValue {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;

      for (int i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date.day == weekDay.day &&
            recentTransaction[i].date.month == weekDay.month &&
            recentTransaction[i].date.year == weekDay.year) {
          totalSum += recentTransaction[i].amount;
        }
      }
      // print(DateFormat.E().format(weekDay));
      // print(totalSum);
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 2),
        'amount': totalSum
      };
    });
  }

  double get maxSpending {
    return groupedTransactionValue.fold(
        0.0, (previousValue, element) => previousValue + element['amount']);
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValue);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: groupedTransactionValue
              .map(
                (e) => Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                    label: e['day'],
                    spendingAmount: e['amount'],
                    totalSpendingPercentage: maxSpending == 0
                        ? 0.0
                        : (e['amount'] as double) / maxSpending,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
