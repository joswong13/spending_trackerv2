import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spending_tracker/Core/Constants/ColorPalette.dart';
import 'package:intl/intl.dart';
import 'package:spending_tracker/Core/ViewModels/AppProvider.dart';

class SpentCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final monthData = Provider.of<AppProvider>(context);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 8,
      margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.blue,
        ),
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 5),
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Center(
              child: Text(DateFormat.yMMM().format(monthData.date),
                  style: TextStyle(
                    fontSize: 28,
                  ),
                  textScaleFactor: 1.0),
            ),
            Center(
              child: Text(
                "Spent - \$${monthData.sixWeekTotal}",
                style: TextStyle(fontSize: 28),
              ),
            ),
            // Center(
            //   child: Text(
            //     "Budget",
            //     style: TextStyle(fontSize: 38),
            //   ),
            // ),
            //Budget comes later
          ],
        ),
      ),
    );
  }
}
