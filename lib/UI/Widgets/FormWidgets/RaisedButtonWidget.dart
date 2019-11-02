import 'package:flutter/material.dart';
import 'package:spending_tracker/UI/Views/AddExpenseView/AddTransactionView.dart';

const roundedRect30 = RoundedRectangleBorder(
  borderRadius: BorderRadius.all(
    Radius.circular(30),
  ),
);

Text raisedButtonTextSize14(String buttonText) {
  return Text(
    buttonText,
    textScaleFactor: 1,
    style: TextStyle(fontSize: 14, color: Colors.black),
  );
}

RaisedButton emptyTransactionListAddButton(BuildContext context, String title) {
  return RaisedButton.icon(
    elevation: 8,
    shape: roundedRect30,
    icon: Icon(
      Icons.add_circle_outline,
      color: Colors.black,
    ),
    label: Text(
      title,
      textScaleFactor: 1,
      style: TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.w500),
    ),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) {
          return TransactionScreen();
        }),
      );
    },
  );
}
