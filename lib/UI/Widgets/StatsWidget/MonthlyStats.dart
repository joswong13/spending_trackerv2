import 'package:flutter/material.dart';
import 'package:spending_tracker/Core/Constants/ColorPalette.dart';
import 'package:spending_tracker/Core/Models/Stat.dart';
import 'package:intl/intl.dart';

class MonthlyStats extends StatelessWidget {
  final StatMonth _statMonth;
  final double _rangeTotal;

  /// Used in the sliver list to display each month with a bar graph next to it given the [StatMonth] object and the total.
  MonthlyStats(this._statMonth, this._rangeTotal);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Row(
        children: <Widget>[
          Container(
            child: Text(DateFormat.yMMM().format(_statMonth.date)),
            width: MediaQuery.of(context).size.width * 0.2,
          ),
          Container(
            height: 30,
            width: MediaQuery.of(context).size.width * 0.70,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: darkGrey,
                    border: Border.all(color: darkGrey, width: 3),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: _statMonth.total > 0.0 ? _statMonth.total / _rangeTotal : 0.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: primaryGreen,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    "\$" + _statMonth.total.toStringAsFixed(2),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                )
              ],
              overflow: Overflow.clip,
            ),
          ),
        ],
      ),
    );
  }
}
