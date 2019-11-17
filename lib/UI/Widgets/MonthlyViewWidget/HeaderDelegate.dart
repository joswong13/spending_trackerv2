//import 'package:flutter/src/rendering/sliver_persistent_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:spending_tracker/Core/Constants/ColorPalette.dart';
import 'package:spending_tracker/Core/ViewModels/AppProvider.dart';

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
    final monthData = Provider.of<AppProvider>(context);

    return Stack(overflow: Overflow.visible, children: [
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
            DateFormat.yMMM().format(monthData.date),
            textScaleFactor: 1.0,
            style: TextStyle(fontSize: 28, color: Theme.of(context).primaryColor),
          )),
        ),
      ),
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
                  "Spent - \$${monthData.monthlyTotal.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 28,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Align(
        alignment: Alignment.centerLeft,
        child: IconButton(
          onPressed: () {
            DateTime newMonth = DateTime.utc(monthData.date.year, monthData.date.month - 1, 1);
            monthData.changeDate(newMonth);
          },
          iconSize: 30,
          icon: Icon(
            Icons.chevron_left,
          ),
        ),
      ),
      Align(
        alignment: Alignment.centerRight,
        child: IconButton(
          onPressed: () {
            DateTime newMonth = DateTime.utc(monthData.date.year, monthData.date.month + 1, 1);
            monthData.changeDate(newMonth);
          },
          iconSize: 30,
          icon: Icon(
            Icons.chevron_right,
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

// return Dismissible(
//       resizeDuration: null,
//       key: UniqueKey(),
//       onDismissed: (DismissDirection direction) {
//         if (direction == DismissDirection.startToEnd) {
//           DateTime newMonth = DateTime.utc(monthData.date.year, monthData.date.month - 1, 1);
//           monthData.changeDate(newMonth);
//         } else {
//           DateTime newMonth = DateTime.utc(monthData.date.year, monthData.date.month + 1, 1);
//           monthData.changeDate(newMonth);
//         }
//       },
//       child: Container(
//         //margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
//         child: Stack(children: [
//           Container(
//             height: maxExtent,
//             margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
//             decoration: BoxDecoration(
//               //borderRadius: BorderRadius.circular(30),
//               //color: greySlightlyDarkBlue,
//               color: blueDarkDarkBlue,
//               //color: printOffset(shrinkOffset),
//               // boxShadow: <BoxShadow>[
//               //   BoxShadow(color: Colors.black54, offset: Offset(1.1, 1.1), blurRadius: 10.0),
//               // ],
//             ),
//             child: ListView(
//               padding: EdgeInsets.symmetric(vertical: 5),
//               physics: NeverScrollableScrollPhysics(),
//               children: <Widget>[
//                 Center(
//                   child: Text(DateFormat.yMMM().format(monthData.date),
//                       style: TextStyle(
//                         fontSize: 28,
//                       ),
//                       textScaleFactor: 1.0),
//                 ),
//                 Center(
//                   child: Text(
//                     "Spent - \$${monthData.sixWeekTotal}",
//                     style: TextStyle(fontSize: 28),
//                   ),
//                 ),
//                 // Center(
//                 //   child: Text(
//                 //     "Budget",
//                 //     style: TextStyle(fontSize: 38),
//                 //   ),
//                 // ),
//                 //Budget comes later
//               ],
//             ),
//           ),
//           Align(
//             alignment: Alignment.centerLeft,
//             child: Icon(
//               Icons.chevron_left,
//               size: 38,
//             ),
//           ),
//           Align(
//             alignment: Alignment.centerRight,
//             child: Icon(
//               Icons.chevron_right,
//               size: 38,
//             ),
//           ),
//         ]),
//       ),
//     );

// return Container(
//       child: Stack(children: [
//         AnimatedOpacity(
//           opacity: topHeaderVisible(shrinkOffset) ? 1.0 : 0.0,
//           duration: Duration(milliseconds: 100),
//           child: Container(
//             //height: minExtent,
//             margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
//             decoration: BoxDecoration(
//               //color: blueDarkDarkBlue,
//               color: Color.fromRGBO(29, 29, 29, 1),
//             ),
//             child: Center(
//               child: Text(DateFormat.yMMM().format(monthData.date),
//                   style: TextStyle(
//                     fontSize: 28,
//                   ),
//                   textScaleFactor: 1.0),
//             ),
//           ),
//         ),
//         AnimatedOpacity(
//           opacity: topHeaderVisible(shrinkOffset) ? 0.0 : 1.0,
//           duration: Duration(milliseconds: 100),
//           // child: Card(
//           //   shape: RoundedRectangleBorder(
//           //     borderRadius: BorderRadius.circular(15),
//           //   ),
//           //   elevation: 8,

//           child: Container(
//             margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
//             height: maxExtent,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(15),
//               //color: blueDarkDarkBlue,
//               //color: Color.fromRGBO(255, 255, 255, 0.06),
//             ),
//             child: ListView(
//               padding: EdgeInsets.symmetric(vertical: 5),
//               physics: NeverScrollableScrollPhysics(),
//               children: <Widget>[
//                 Center(
//                   child: Text(DateFormat.yMMM().format(monthData.date),
//                       style: TextStyle(
//                         fontSize: 28,
//                       ),
//                       textScaleFactor: 1.0),
//                 ),
//                 Center(
//                   child: Text(
//                     "Spent - \$${monthData.sixWeekTotal}",
//                     style: TextStyle(fontSize: 28),
//                   ),
//                 ),
//                 // Center(
//                 //   child: Text(
//                 //     "Budget",
//                 //     style: TextStyle(fontSize: 38),
//                 //   ),
//                 // ),
//                 //Budget comes later
//               ],
//             ),
//           ),
//           //),
//         ),
//         Align(
//           alignment: Alignment.centerLeft,
//           child: IconButton(
//             onPressed: () {
//               DateTime newMonth = DateTime.utc(monthData.date.year, monthData.date.month - 1, 1);
//               monthData.changeDate(newMonth);
//             },
//             iconSize: 30,
//             icon: Icon(
//               Icons.chevron_left,
//             ),
//           ),
//         ),
//         Align(
//           alignment: Alignment.centerRight,
//           child: IconButton(
//             onPressed: () {
//               DateTime newMonth = DateTime.utc(monthData.date.year, monthData.date.month + 1, 1);
//               monthData.changeDate(newMonth);
//             },
//             iconSize: 30,
//             icon: Icon(
//               Icons.chevron_right,
//             ),
//           ),
//         ),
//       ]),
//     );
