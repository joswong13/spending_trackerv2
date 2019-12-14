import 'package:flutter/material.dart';
import 'package:spending_tracker/Core/Constants/ColorPalette.dart';
import 'package:spending_tracker/Core/Constants/ErrorCode.dart';

/// Given the current selected month and the list of years to render, render a dialog window that lets users select the month and year.
/// After the user selects the month and day, give a DateTime object to the changeDate function.
Future<DateTime> monthSelector(BuildContext context, int month, int year, List<int> listOfYears) async {
  DateTime date = await _monthSelector(context, month, year, listOfYears, 'Select Month and Year');
  return date;
}

Container _pageViewContainer(String title) {
  return Container(
    height: 100,
    child: Center(
      child: Text(
        title,
        textScaleFactor: 1,
        style: TextStyle(fontSize: 20),
      ),
    ),
  );
}

Future<DateTime> _monthSelector(BuildContext context, int month, int year, List<int> listOfYears, String title) async {
  int pageOfMonth = month - 1;
  int pageOfYear = listOfYears.indexOf(year);

  final List<String> months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];

  PageController monthPC = PageController(initialPage: month - 1, viewportFraction: 0.2);
  PageController yearPC = PageController(initialPage: pageOfYear, viewportFraction: 0.2);

  DateTime date = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          title: Column(
            children: <Widget>[
              Text(title),
              Divider(
                color: Colors.white70,
              ),
            ],
          ),
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.5,
              child: Stack(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      //Left side of dialog for month
                      Expanded(
                        child: PageView(
                          controller: monthPC,
                          onPageChanged: (int page) {
                            pageOfMonth = page;
                          },
                          scrollDirection: Axis.vertical,
                          children: months.map((month) {
                            return _pageViewContainer(month);
                          }).toList(),
                        ),
                      ),
                      //Right side of dialog for year
                      Expanded(
                        child: PageView(
                          controller: yearPC,
                          onPageChanged: (int page) {
                            pageOfYear = page;
                          },
                          scrollDirection: Axis.vertical,
                          children: listOfYears.map((year) {
                            return _pageViewContainer(year.toString());
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.chevron_left,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 50,
                      color: Color.fromRGBO(255, 255, 255, 0.3),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      Icons.chevron_right,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  child: const Text(
                    'OK',
                    style: TextStyle(color: primaryGreen),
                  ),
                  onPressed: () async {
                    Navigator.pop(context, DateTime.utc(listOfYears[pageOfYear], pageOfMonth + 1, 1));
                  },
                ),
                FlatButton(
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: primaryGreen),
                  ),
                  onPressed: () {
                    Navigator.pop(context, null);
                  },
                ),
              ],
            ),
          ],
        );
      });

  return date;
}

Future<Map<String, dynamic>> statMonthSelector(
    BuildContext context, List<int> listOfYears, DateTime beginQueryDate, DateTime endQueryDate) async {
  Map<String, dynamic> dateMap = {};

  DateTime begin =
      await _monthSelector(context, beginQueryDate.month, beginQueryDate.year, listOfYears, 'Select The Beginning');

  if (begin != null) {
    dateMap["begin"] = begin;
  } else {
    return null;
  }

  DateTime end = await _monthSelector(context, endQueryDate.month, endQueryDate.year, listOfYears, 'Select The End');

  if (end != null) {
    if (end.isAfter(begin)) {
      dateMap["end"] = DateTime.utc(end.year, end.month + 1, 0);
      dateMap["valid"] = true;
    } else {
      dateMap["error"] = ERR_STAT_END_DATE;
      dateMap["valid"] = false;
    }
  } else {
    return null;
  }

  return dateMap;
}
