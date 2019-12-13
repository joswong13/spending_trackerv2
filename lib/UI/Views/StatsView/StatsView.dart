import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spending_tracker/Core/Models/Stat.dart';
import 'package:spending_tracker/Core/ViewModels/AppProvider.dart';
import 'package:spending_tracker/UI/Widgets/Dialog/ErrorDialog.dart';
import 'package:spending_tracker/UI/Widgets/Dialog/MonthYearDialog.dart';
import 'package:spending_tracker/UI/Widgets/StatsWidget/CategoryStats.dart';
import 'package:spending_tracker/UI/Widgets/StatsWidget/HeaderCard.dart';
import 'package:spending_tracker/UI/Widgets/StatsWidget/MonthlyStats.dart';

class StatsView extends StatefulWidget {
  @override
  _StatsViewState createState() => _StatsViewState();
}

class _StatsViewState extends State<StatsView> {
  DateTime begin;
  DateTime end;
  Stat stat;
  bool busy = true;

  //Ensures the widget is still mounted before setting state
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();

    DateTime temp = DateTime.now();

    setState(() {
      begin = DateTime.utc(temp.year, temp.month - 11, 1);
      end = DateTime.utc(temp.year, temp.month + 1, 0);
    });
  }

  // This method runs right after initState. This performs the query on widget build rather than passing in data from the constructor.
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    Stat tempStat = await _queryStat(begin, end);

    setState(() {
      stat = tempStat;
      busy = false;
    });
  }

  Future<Stat> _queryStat(DateTime beginQuery, DateTime endQuery) async {
    return await Provider.of<AppProvider>(context)
        .getStatsView(beginQuery.millisecondsSinceEpoch, endQuery.millisecondsSinceEpoch);
  }

  //Another method when user clicks search method
  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);

    return busy
        ? Center(
            child: CircularProgressIndicator(),
          )
        : CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: InkWell(
                  onTap: () async {
                    Map<String, dynamic> monthSelectorMap =
                        await statMonthSelector(context, appProvider.listOfYears, begin, end);

                    if (monthSelectorMap != null &&
                        monthSelectorMap["valid"] &&
                        (monthSelectorMap["begin"] != begin || monthSelectorMap["end"] != end)) {
                      //if monthSelectorMap is null, it means the user pressed cancel
                      setState(() {
                        busy = true;
                      });

                      Stat tempStat = await _queryStat(monthSelectorMap["begin"], monthSelectorMap["end"]);

                      setState(() {
                        begin = monthSelectorMap["begin"];
                        end = monthSelectorMap["end"];
                        stat = tempStat;
                        busy = false;
                      });
                    } else if (monthSelectorMap != null && !monthSelectorMap["valid"]) {
                      errorMsgDialog(context, monthSelectorMap["error"]);
                    }
                  },
                  child: HeaderCard(begin, end, stat.total, stat.numberOfTransactions),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return MonthlyStats(stat.statMonth[index], stat.total);
                  },
                  childCount: stat.statMonth.length,
                ),
              ),
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                  return CategoryStat(stat.statCategory[index]);
                }, childCount: stat.statCategory.length),
              ),
              //Container gives extra space above the last item and the FAB
              SliverToBoxAdapter(
                child: Container(
                  height: 30,
                ),
              ),
            ],
          );
  }
}
