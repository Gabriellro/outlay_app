// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:outlay/components/_exports.dart';
import 'package:outlay/models/_exports.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  const Chart({Key? key, required this.recentTransaction}) : super(key: key);

  List<Map<String, dynamic>> get groupedTransactions =>
      List.generate(7, (index) {
        final weekDay = DateTime.now().subtract(Duration(days: index));
        double totalSum = 0.0;

        for (var i = 0; i < recentTransaction.length; i++) {
          bool isSameDay = recentTransaction[i].date.day == weekDay.day;
          bool isSameMonth = recentTransaction[i].date.month == weekDay.month;
          bool isSameYear = recentTransaction[i].date.year == weekDay.year;

          if (isSameDay && isSameMonth && isSameYear) {
            totalSum += recentTransaction[i].value;
          }
        }

        return {
          'day': DateFormat.E().format(weekDay)[0],
          'value': totalSum,
        };
      });
  double get _weekTotalValue =>
      groupedTransactions.fold(0.0, (sum, tr) => sum + tr['value']);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(
          24,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ...groupedTransactions
              .map(
                (tr) => Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                    label: tr['day'],
                    value: tr['value'],
                    percentage: _weekTotalValue == 0
                        ? 0
                        : tr['value'] / _weekTotalValue,
                  ),
                ),
              )
              .toList()
              .reversed
        ],
      ),
    );
  }
}
