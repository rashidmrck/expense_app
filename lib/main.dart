import 'package:expense_app/model/expense.dart';
import 'package:expense_app/widgets/chart.dart';
import 'package:expense_app/widgets/new_transaction.dart';
import 'package:expense_app/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.purple,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              button: TextStyle(color: Colors.white),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
        ),
      ),
      title: 'Expence Planner',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (bcontext) {
        return NewTransaction(
          addTransaction: _addNewTransaction,
        );
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
    );
  }

  final List<Expense> _userTransactions = [
    // Expense(amount: 12.69, date: DateTime.now(), id: 'ASDSD', title: 'Food'),
    // Expense(amount: 22.74, date: DateTime.now(), id: 'sdas', title: 'Bag'),
    // Expense(
    //     amount: 45.12, date: DateTime.now(), id: 'AStwtDSD', title: 'Cable'),
  ];

  List<Expense> get _recentTransaction {
    return _userTransactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime date) {
    var trx = Expense(
      amount: amount,
      date: date,
      id: DateTime.now().toString(),
      title: title,
    );
    setState(() {
      _userTransactions.add(trx);
    });
  }

  void _deleteTransacion(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () => _showBottomSheet(context)),
        ],
        title: Text('Expences'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        child: Text(
          'Expence',
          style: TextStyle(
            fontSize: 11,
          ),
        ),
        onPressed: () => _showBottomSheet(context),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(
              recentTransaction: _recentTransaction,
            ),
            TransactionList(
              userTransaction: _userTransactions,
              delete: _deleteTransacion,
            ),
          ],
        ),
      ),
    );
  }
}
