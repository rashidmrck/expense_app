import 'dart:io';

import 'package:expense_app/model/expense.dart';
import 'package:expense_app/widgets/chart.dart';
import 'package:expense_app/widgets/new_transaction.dart';
import 'package:expense_app/widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';
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
  bool _showChart = true;

  void _showBottomSheet() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      )),
      context: context,
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: NewTransaction(
            addTransaction: _addNewTransaction,
          ),
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
    final mediaquery = MediaQuery.of(context);
    final _landscape = mediaquery.orientation == Orientation.landscape;

    final PreferredSizeWidget _appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Expences'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _showBottomSheet(),
                ),
              ],
            ),
          )
        : AppBar(
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _showBottomSheet(),
              ),
            ],
            title: Text('Expences'),
          );

    final _tranListContainer = Container(
      height: (mediaquery.size.height -
              _appBar.preferredSize.height -
              mediaquery.padding.top) *
          .7,
      child: TransactionList(
        userTransaction: _userTransactions,
        delete: _deleteTransacion,
      ),
    );

    final _pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (_landscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Show Chart',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Switch.adaptive(
                      activeColor: Theme.of(context).primaryColor,
                      value: _showChart,
                      onChanged: (value) {
                        setState(() {
                          _showChart = value;
                        });
                      })
                ],
              ),
            if (!_landscape)
              Container(
                height: (mediaquery.size.height -
                        _appBar.preferredSize.height -
                        mediaquery.padding.top) *
                    .3,
                child: Chart(
                  recentTransaction: _recentTransaction,
                ),
              ),
            if (!_landscape) _tranListContainer,
            if (_landscape)
              _showChart
                  ? Container(
                      height: (mediaquery.size.height -
                              _appBar.preferredSize.height -
                              mediaquery.padding.top) *
                          .5,
                      child: Chart(
                        recentTransaction: _recentTransaction,
                      ),
                    )
                  : _tranListContainer,
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: _pageBody,
            navigationBar: _appBar,
          )
        : Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            appBar: _appBar,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    backgroundColor: Colors.purple,
                    child: Text(
                      'Expence',
                      style: TextStyle(
                        fontSize: 11,
                      ),
                    ),
                    onPressed: () => _showBottomSheet(),
                  ),
            body: _pageBody,
          );
  }
}
