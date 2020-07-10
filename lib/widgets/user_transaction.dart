import 'package:expense_app/model/expense.dart';
import 'package:expense_app/widgets/new_transaction.dart';
import 'package:expense_app/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

class UserTransaction extends StatefulWidget {
  @override
  _UserTransactionState createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  final List<Expense> _userTransaction = [
    Expense(amount: 12.69, date: DateTime.now(), id: 'ASDSD', title: 'Food'),
    Expense(amount: 22.74, date: DateTime.now(), id: 'sdas', title: 'Bag'),
    Expense(
        amount: 45.12, date: DateTime.now(), id: 'AStwtDSD', title: 'Cable'),
  ];

  void _addNewTransaction(String title, double amount) {
    var trx = Expense(
      amount: amount,
      date: DateTime.now(),
      id: DateTime.now().toString(),
      title: title,
    );
    setState(() {
      _userTransaction.add(trx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewTransaction(
          addTransaction: _addNewTransaction,
        ),
        TransactionList(
          userTransaction: _userTransaction,
        ),
      ],
    );
  }
}
