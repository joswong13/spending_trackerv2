import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spending_tracker/Core/ViewModels/AppProvider.dart';
import 'package:spending_tracker/UI/Widgets/FormWidgets/RaisedButtonWidget.dart';

class EmptyTransactionListSliver extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          Text(
            "Empty",
            textScaleFactor: 1,
            style: TextStyle(fontSize: 30),
          ),
          emptyTransactionListAddButton(context, "Add", date: appProvider.date),
        ],
      ),
    );
  }
}
