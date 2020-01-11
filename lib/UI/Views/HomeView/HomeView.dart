//import 'package:spending_tracker/Core/Constants/SizeConfig.dart';
import 'package:flutter/material.dart';

//Widgets
import 'package:spending_tracker/UI/Views/AddExpenseView/AddTransactionView.dart';
import 'package:spending_tracker/UI/Views/SettingsView/SettingsView.dart';
import 'package:spending_tracker/UI/Views/StatsView/StatsView.dart';
import '../CategoryTransactionView/CategoryOverviewCard.dart';
import '../Monthly/MonthlyViewSliver.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

//BudgetView(),
  @override
  Widget build(BuildContext context) {
    // final SizeConfig sizeConfig = SizeConfig();
    // sizeConfig.initValues(context);

    return WillPopScope(
      onWillPop: () {
        return Future(() => false);
      },
      child: Scaffold(
        key: GlobalKey<ScaffoldState>(),
        body: SafeArea(
          child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: <Widget>[MonthlyViewSliver(), CategoryOverviewCard(), StatsView(), SettingsView()],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          tooltip: 'Add',
          isExtended: true,
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.black,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) {
                return TransactionScreen();
              }),
            );
          },
        ),
        bottomNavigationBar: BottomAppBar(
          notchMargin: 5.0,
          clipBehavior: Clip.antiAlias,
          shape: CircularNotchedRectangle(),
          child: Material(
            color: Colors.black,
            child: TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.calendar_today),
                ),
                Tab(
                  icon: Icon(Icons.category),
                ),
                Tab(
                  icon: Icon(Icons.insert_chart),
                ),
                Tab(
                  icon: Icon(Icons.settings),
                ),
              ],
              controller: _tabController,
              labelColor: Theme.of(context).primaryColor,
              indicatorColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Colors.grey[800],
            ),
          ),
        ),
      ),
    );
  }
}
