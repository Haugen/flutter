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
    var appBar = AppBar(
      title: Text('Personal expenses'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        )
      ],
    );

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: appBar,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _userTransactions.isNotEmpty
              ? Column(
                  children: <Widget>[
                    Container(
                      height: (MediaQuery.of(context).size.height -
                              appBar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.29,
                      child: Chart(_recentTransactions),
                    ),
                    Container(
                      height: (MediaQuery.of(context).size.height -
                              appBar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.71,
                      child: TransactionList(
                          _userTransactions, _deleteTransaction),
                    ),
                  ],
                )
              : NoTransactionsYet()
        ],
      ),
    );
  }
}
