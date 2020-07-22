import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double totalSpendingPercentage;

  ChartBar({this.label, this.spendingAmount, this.totalSpendingPercentage});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrant) {
      return Column(
        children: <Widget>[
          Container(
            height: constrant.maxHeight * .15,
            child: FittedBox(
              child: Text('₹${spendingAmount.toStringAsFixed(0)}'),
            ),
          ),
          SizedBox(
            height: constrant.maxHeight * .05,
          ),
          Container(
            height: constrant.maxHeight * 0.6,
            width: 20,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(220, 220, 220, 1),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.bottomStart,
                  child: FractionallySizedBox(
                    heightFactor: totalSpendingPercentage,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: constrant.maxHeight * .05,
          ),
          Container(
            height: constrant.maxHeight * .15,
            child: FittedBox(
              child: Text(label),
            ),
          ),
        ],
      );
    });
  }
}
