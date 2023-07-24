import 'package:flutter/material.dart';
import 'package:personal_expenses/src/widgets/chart_bar.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction>? recentTransactions;

  Chart({this.recentTransactions});

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;

      for (var i = 0; i < recentTransactions!.length; i++) {
        if (recentTransactions![i].date!.day == weekDay.day &&
            recentTransactions![i].date!.month == weekDay.month &&
            recentTransactions![i].date!.year == weekDay.year) {
          totalSum += recentTransactions![i].amount!;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + double.parse('${item['amount']}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: LayoutBuilder(
                builder: ((context, constraints) {
                  return Column(
                    children: [
                      Container(
                          height: constraints.maxHeight * 0.10,
                          child: FittedBox(child: Text('${data['day']}'))),
                      SizedBox(height: constraints.maxHeight * 0.05),
                      ChartBar(
                          constraints.maxHeight * 0.7,
                          totalSpending == 0.0
                              ? 0.0
                              : (data['amount'] as double) / totalSpending),
                      SizedBox(height: constraints.maxHeight * 0.05),
                      Container(
                        height: constraints.maxHeight * 0.10,
                        child: FittedBox(
                            child: Text(
                                '\$${(data['amount'] as double).toStringAsFixed(0)}')),
                      ),
                    ],
                  );
                }),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
