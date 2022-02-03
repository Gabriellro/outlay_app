import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double value;
  final double percentage;

  const ChartBar({
    Key? key,
    required this.label,
    required this.value,
    required this.percentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: [
          SizedBox(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(
              child: Text(value.toStringAsFixed(2)),
            ),
          ),
          SizedBox(height: constraints.maxHeight * 0.05),
          Container(
            height: constraints.maxHeight * 0.60,
            width: 10,
            decoration: const BoxDecoration(),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Theme.of(context).backgroundColor,
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: percentage,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: constraints.maxHeight * 0.05),
          SizedBox(
            height: constraints.maxHeight * 0.10,
            child: Text(label),
          )
        ],
      );
    });
  }
}
