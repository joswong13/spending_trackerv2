import 'package:flutter/material.dart';
import 'package:spending_tracker/UI/Widgets/FormWidgets/RaisedButtonWidget.dart';

class EmptyTransactionListSliver extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          Text(
            "No Transactions",
            textScaleFactor: 1,
            style: TextStyle(fontSize: 30),
          ),
          emptyTransactionListAddButton(context, "Add Transaction"),
        ],
      ),
    );
  }
}
