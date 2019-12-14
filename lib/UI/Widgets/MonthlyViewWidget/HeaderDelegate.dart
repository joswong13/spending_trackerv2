import 'package:flutter/src/rendering/sliver_persistent_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:spending_tracker/Core/Constants/ColorPalette.dart';
import 'package:spending_tracker/Core/Constants/ErrorCode.dart';
import 'package:spending_tracker/Core/ViewModels/AppProvider.dart';
import 'package:spending_tracker/UI/Widgets/Dialog/ErrorDialog.dart';
import 'package:spending_tracker/UI/Widgets/Dialog/MonthYearDialog.dart';

class HeaderDelegate implements SliverPersistentHeaderDelegate {
  HeaderDelegate({this.minExtent, this.maxExtent});

  final double minExtent;
  final double maxExtent;

  bool topHeaderVisible(double shrinkOffset) {
    final double alpha = (shrinkOffset / (this.maxExtent - this.minExtent)).clamp(0.0, 1.0);
    if (alpha >= 0.5) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final appProvider = Provider.of<AppProvider>(context);

    return Stack(overflow: Overflow.visible, children: [
      //Head at top of screen
      AnimatedOpacity(
        opacity: topHeaderVisible(shrinkOffset) ? 1.0 : 0.0,
        duration: Duration(milliseconds: 100),
        child: Container(
          //height: minExtent,
          margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
          decoration: BoxDecoration(
            color: darkGrey,
          ),
          child: Center(
              child: Text(
            DateFormat.yMMM().format(appProvider.date),
            textScaleFactor: 1.0,
            style: TextStyle(fontSize: 28, color: Theme.of(context).primaryColor),
          )),
        ),
      ),

      //Header at the middle of screen
      AnimatedOpacity(
        opacity: topHeaderVisible(shrinkOffset) ? 0.0 : 1.0,
        duration: Duration(milliseconds: 100),
        child: Container(
          height: maxExtent,
          margin: EdgeInsets.fromLTRB(0, 0, 0, 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            color: darkGrey,
          ),
          child: appProvider.busy
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : InkWell(
                  onTap: () async {
                    DateTime date = await monthSelector(
                      context,
                      appProvider.date.month,
                      appProvider.date.year,
                      appProvider.listOfYears,
                    );
                    if (date != null) {
                      await appProvider.changeDate(date);
                    }
                  },
                  child: ListView(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      Center(
                        child: Text(DateFormat.yMMM().format(appProvider.date),
                            style: TextStyle(
                              fontSize: 28,
                            ),
                            textScaleFactor: 1.0),
                      ),
                      Center(
                        child: Text(
                          "Spent - \$${appProvider.monthlyTotal.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 28,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
      Align(
        alignment: Alignment.centerLeft,
        child: IconButton(
          onPressed: () {
            DateTime newMonth = DateTime.utc(appProvider.date.year, appProvider.date.month - 1, 1);
            if (newMonth.isAfter(appProvider.backwardLimit)) {
              appProvider.changeDate(newMonth);
            } else {
              errorMsgDialog(context, ERR_DATE_PAST_BACKLIMIT);
            }
          },
          iconSize: 30,
          icon: Icon(
            Icons.chevron_left,
            color: topHeaderVisible(shrinkOffset) ? Theme.of(context).primaryColor : Colors.white,
          ),
        ),
      ),
      Align(
        alignment: Alignment.centerRight,
        child: IconButton(
          onPressed: () {
            DateTime newMonth = DateTime.utc(appProvider.date.year, appProvider.date.month + 1, 1);
            if (newMonth.isBefore(appProvider.forwardLimit)) {
              appProvider.changeDate(newMonth);
            } else {
              errorMsgDialog(context, ERR_DATE_PAST_FORWARDLIMIT);
            }
          },
          iconSize: 30,
          icon: Icon(
            Icons.chevron_right,
            color: topHeaderVisible(shrinkOffset) ? Theme.of(context).primaryColor : Colors.white,
          ),
        ),
      ),
    ]);
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration => null;
}
