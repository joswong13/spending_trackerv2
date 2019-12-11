import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spending_tracker/Core/Constants/ColorPalette.dart';

class HeaderCard extends StatelessWidget {
  final DateTime _begin;
  final DateTime _end;
  final double _total;
  final int _numOfTx;

  /// Displays the date time in MMM YYYY format at the top of the CustomScrollView.
  /// Also displays the total and the number of transactions.
  HeaderCard(this._begin, this._end, this._total, this._numOfTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: darkGrey,
      ),
      margin: EdgeInsets.fromLTRB(18, 16, 18, 8),
      padding: EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          Text(
            DateFormat.yMMM().format(_begin) + " - " + DateFormat.yMMM().format(_end),
            style: TextStyle(fontSize: 28),
            textScaleFactor: 1,
          ),
          Text(
            "\$" + _total.toStringAsFixed(2),
            style: TextStyle(fontSize: 28),
            textScaleFactor: 1,
          ),
          Text(
            _numOfTx.toString() + " Transaction(s)",
            style: TextStyle(fontSize: 28),
            textScaleFactor: 1,
          )
        ],
      ),
    );
  }
}
