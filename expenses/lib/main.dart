import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/no_transactions_yet.dart';
import './widgets/chart.dart';
import './models/transaction.dart';

var uuid = new Uuid();

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal expenses',
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: Theme.of(context).textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              button: TextStyle(color: Colors.white),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                ),
              ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: uuid.v1(),
      title: 'Adidas Stan Smith',
      amount: 49.55,
      date: DateTime.now(),
    ),
    Transaction(
      id: uuid.v1(),
      title: 'Cheap Monday Jeans',
      amount: 39.99,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      id: uuid.v1(),
      title: 'Good \'ol Boots',
      amount: 120.00,
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
    Transaction(
      id: uuid.v1(),
      title: 'T-shirt',
      amount: 19.99,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: uuid.v1(),
      title: 'Nice dinner',
      amount: 12.50,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction(
      id: uuid.v1(),
      title: 'Jacket',
      amount: 65.99,
      date: DateTime.now().subtract(Duration(days: 6)),
    ),
    Transaction(
      id: uuid.v1(),
      title: 'Bogotá brewed beer',
      amount: 9.99,
      date: DateTime.now().subtract(Duration(days: 6)),
    ),
    Transaction(
      id: uuid.v1(),
      title: 'iPhone charger',
      amount: 15.50,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  bool _showChart = false;

  void _addNewTransaction(
    String txTitle,
    double txAmount,
    DateTime chosenDate,
  ) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: uuid.v1(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    // To check phone orientation.
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    var showChartSwitch = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Show Chart:',
          style: Theme.of(context).textTheme.title,
        ),
        Switch.adaptive(
          value: _showChart,
          onChanged: (val) {
            setState(() {
              _showChart = val;
            });
          },
        ),
      ],
    );

    PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Personal expenses'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _startAddNewTransaction(context),
                )
              ],
            ),
          )
        : AppBar(
            title: Text('Personal expenses'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _startAddNewTransaction(context),
              )
            ],
          );

    var preferredHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    final pageBody = SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _userTransactions.isNotEmpty
              ? Column(
                  children: <Widget>[
                    showChartSwitch,
                    if (_showChart)
                      Container(
                        height: preferredHeight * 0.3,
                        child: Chart(_recentTransactions),
                      ),
                    Container(
                      height: _showChart
                          ? preferredHeight * 0.6
                          : preferredHeight * 0.9,
                      child: TransactionList(
                        _userTransactions,
                        _deleteTransaction,
                      ),
                    ),
                  ],
                )
              : NoTransactionsYet()
        ],
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            floatingActionButton: Platform.isIOS
                ? SizedBox.shrink()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _startAddNewTransaction(context),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            appBar: appBar,
            body: pageBody,
          );
  }
}
