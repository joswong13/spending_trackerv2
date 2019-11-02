import 'package:spending_tracker/Core/Constants/ColorPalette.dart';
import 'package:spending_tracker/Core/Constants/SizeConfig.dart';
import 'package:flutter/material.dart';

//Widgets
import 'package:spending_tracker/UI/Views/AddExpenseView/AddTransactionView.dart';
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
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

//BudgetView(),
  @override
  Widget build(BuildContext context) {
    final SizeConfig sizeConfig = SizeConfig();
    sizeConfig.initValues(context);

    return Scaffold(
      key: GlobalKey<ScaffoldState>(),
      body: SafeArea(
        child: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: <Widget>[
            MonthlyViewSliver(),
            CategoryOverviewCard(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add',
        isExtended: true,
        backgroundColor: tealFadedPoster,
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
              Tab(icon: Icon(Icons.calendar_today)),
              Tab(icon: Icon(Icons.category)),
            ],
            controller: _tabController,
            labelColor: Theme.of(context).primaryColor,
            indicatorColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Colors.blueGrey,
          ),
        ),
      ),
    );
  }
}

//static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
// static List<Widget> _widgetOptions = <Widget>[
//   MonthlyViewSliver(),
//   CategoryOverviewCard(),
// ];
//  final BottomNavBarScreenProvider indexProvider = Provider.of<BottomNavBarScreenProvider>(context);
//     final monthData = Provider.of<AppProvider>(context);

//     //BottomNavBar is always 8% of usable screen
//     final bottomNavBarHieght = sizeConfig.blockSizeVertical * 8;
// bottomNavigationBar: SizedBox(
//   height: bottomNavBarHieght,
//   child: BottomNavigationBar(
//     type: BottomNavigationBarType.shifting,
//     items: const <BottomNavigationBarItem>[
//       BottomNavigationBarItem(
//         icon: Icon(Icons.calendar_today),
//         title: Text('Spending'),
//         backgroundColor: Colors.black,
//       ),
//       BottomNavigationBarItem(
//         icon: Icon(Icons.category),
//         title: Text('Category'),
//         backgroundColor: Colors.black,
//       ),
//       // BottomNavigationBarItem(
//       //   icon: Icon(Icons.local_atm),
//       //   title: Text('Budget'),
//       //   backgroundColor: Colors.black,
//       // ),
//       BottomNavigationBarItem(
//         icon: Icon(Icons.add_circle_outline),
//         title: Text('Add'),
//         backgroundColor: Colors.black,
//       ),
//     ],
//     currentIndex: indexProvider.getCurrentPageIndex,
//     selectedItemColor: Theme.of(context).primaryColor,
//     onTap: (int index) {
//       if (index <= 1) {
//         indexProvider.currentPageIndex = index;
//       } else {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (_) {
//             return TransactionScreen();
//           }),
//         );
//       }
//     },
//   ),
// ),
