import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:expense_app/model/expense.dart';

class TransactionList extends StatelessWidget {
  final List<Expense> userTransaction;
  final Function delete;
  TransactionList({this.userTransaction, this.delete});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 520,
      child: userTransaction.isEmpty
          ? LayoutBuilder(builder: (context, constrant) {
              return Column(
                children: <Widget>[
                  Text(
                    'No transaction found.',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: constrant.maxHeight * .7,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              );
            })
          : ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: userTransaction.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FittedBox(
                          child: Text(
                            "₹" +
                                userTransaction[index]
                                    .amount
                                    .toStringAsFixed(2),
                            style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.button.color),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      userTransaction[index].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat('dd-MMMM-yyyy')
                          .format(userTransaction[index].date),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                      ),
                      color: Theme.of(context).errorColor,
                      onPressed: () => delete(userTransaction[index].id),
                    ),
                  ),
                );
              }),
    );
  }
}
