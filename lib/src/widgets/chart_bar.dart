import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final double? spendingPctOfTotal;
  final double? maxHeight;

  ChartBar(this.maxHeight, this.spendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: maxHeight,
      width: 15,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1.0),
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          FractionallySizedBox(
            heightFactor: 1.0 - spendingPctOfTotal!,
            widthFactor: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
