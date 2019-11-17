import 'package:flutter/material.dart';
import 'package:spending_tracker/UI/Widgets/MonthlyViewWidget/TransactionItemCard.dart';
import 'package:intl/intl.dart';

class TransactionItems extends StatelessWidget {
  final Map<String, dynamic> transaction;

  TransactionItems({this.transaction});
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 1,
      margin: EdgeInsets.fromLTRB(16, 5, 16, 5),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  DateFormat("EEE d").format(transaction["date"]),
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Text(
                  "\$${transaction["dailyTotal"].toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 0.0,
          ),
          ...transaction["transactions"].map((tx) {
            return TransactionItemCard(txData: tx);
          }),
        ],
      ),
      //),
    );
  }
}

//style: TextStyle(fontSize: 18, color: Colors.blue[200]),
//style: TextStyle(fontSize: 18, color: tealLessThanRobinsEgg),

// child: Container(
//   decoration: BoxDecoration(
//     borderRadius: BorderRadius.circular(15),
//     //color: greySlightlyDarkBlue,
//     //color: Colors.blueGrey[900],
//   ),
