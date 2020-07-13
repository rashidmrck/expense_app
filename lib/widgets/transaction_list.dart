import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:expense_app/model/expense.dart';

class TransactionList extends StatelessWidget {
  final List<Expense> userTransaction;
  TransactionList({this.userTransaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: userTransaction.isEmpty? Column(
        children: <Widget>[
          Text('No transaction found.'),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 200,
            child: Image.asset('assets/images/waiting.png',fit: BoxFit.cover,),
          )
        ],
      ): ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: userTransaction.length,
          itemBuilder: (context, index) {
            return Card(
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.purple, width: 2)),
                    child: Text(
                      "₹" + userTransaction[index].amount.toStringAsFixed(2),
                      style: TextStyle(
                          color: Colors.purple, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        userTransaction[index].title,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(DateFormat('dd-MMMM-yyyy hh:mm a')
                          .format(userTransaction[index].date)),
                    ],
                  )
                ],
              ),
            );
          }),
    );
  }
}
