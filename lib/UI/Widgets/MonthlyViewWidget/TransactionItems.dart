import 'package:flutter/material.dart';
import 'package:spending_tracker/Core/Constants/ColorPalette.dart';
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
      elevation: 8,
      margin: EdgeInsets.fromLTRB(16, 5, 16, 5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: greySlightlyDarkBlue,
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    DateFormat("EEE d").format(transaction["date"]),
                    style: TextStyle(fontSize: 18, color: tealLessThanRobinsEgg),
                  ),
                  Text(
                    "\$${transaction["dailyTotal"].toString()}",
                    style: TextStyle(fontSize: 18, color: tealLessThanRobinsEgg),
                  ),
                ],
              ),
            ),
            Divider(
              height: 0.0,
            ),
            ...transaction["transactions"].map((tx) {
              return TransactionItemCard(txData: tx);
            })
          ],
        ),
      ),
    );
  }
}
