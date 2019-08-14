import 'package:flutter/material.dart';

import './transaction_item.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          ...transactions.map((tx) {
            return TransactionItem(
              key: ValueKey(tx.id),
              transaction: tx,
              deleteTx: deleteTx,
            );
          })
        ],
      ),
    );
  }
}
