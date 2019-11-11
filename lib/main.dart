import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import './Core/ViewModels/AppProvider.dart';
import './UI/Views/HomeView/HomeView.dart';
import 'Core/Constants/ColorPalette.dart';

void main() {
  //sets fullscreen (without bottom nav android nav bar)
  //SystemChrome.setEnabledSystemUIOverlays([]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: darkGrey, //top bar color
    statusBarIconBrightness: Brightness.light, //top bar icons
    systemNavigationBarColor: Colors.black, //bottom bar color
    systemNavigationBarIconBrightness: Brightness.light, //bottom bar icons
  ));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (ctx) => AppProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          dialogTheme: DialogTheme(
            titleTextStyle: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 0.87),
              fontSize: 24,
            ),
          ),
          cardColor: darkGrey,
          scaffoldBackgroundColor: Color.fromRGBO(18, 18, 18, 1),
          buttonTheme: ButtonThemeData(
            buttonColor: primaryGreen,
          ),
          brightness: Brightness.dark,
          primaryColor: primaryGreen,
          iconTheme: IconThemeData(
            color: Color.fromRGBO(255, 255, 255, 0.87),
          ),
          textTheme: TextTheme(
            body1: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 0.87),
            ),
          ),
        ),
        home: HomeView(),
      ),
    );
  }
}

//routes: <String, WidgetBuilder>{'/addTransaction': (BuildContext context) => TransactionScreen()},
// home: Scaffold(
//   appBar: AppBar(
//     title: Text('AppBar'),
//   ),
//   body: MonthlyView(),
// ),

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: new SafeArea(
//           child: Container(
//             color: Colors.black38,
//             child: Center(
//               child: Column(
//                 children: <Widget>[
//                   Text('MONTHLY CALENDAR HERE'),
//                   Text('MONTHLY CALENDAR HERE'),
//                   RaisedButton(
//                     child: Text('Button 1'),
//                     onPressed: () {},
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

//final List<UserTransaction> transactions = [
//   UserTransaction('t1', 'New Shoes', 120.00, DateTime.now(), 'Purchases'),
//   UserTransaction('t2', 'New Shirt', 12.00, DateTime.now(), 'Purchases'),
//   UserTransaction('t3', 'New Shirt', 13.00, DateTime.now(), 'Purchases'),
//   UserTransaction('t4', 'New Shirt', 14.00, DateTime.now(), 'Purchases'),
//   UserTransaction('t5', 'New Shirt', 15.00, DateTime.now(), 'Purchases'),
//   UserTransaction('t6', 'New Shirt', 16.00, DateTime.now(), 'Purchases'),
//   UserTransaction('t7', 'New Shirt', 17.00, DateTime.now(), 'Purchases'),
// ];

// final UserTransaction temp =
//     UserTransaction('t7', 'New Shirt', 17.00, DateTime.now(), 'Purchases');

// onButtonPress() {
//   Firestore.instance.collection('2019').document().setData({
//     'txID': 't7',
//     'description': 'New Shirt',
//     'price': 17.00,
//     'date': DateTime.now(),
//     'category': 'Purchases'
//   }).then((resp) {
//     print('DONE!!');
//   });
// }
// body: SingleChildScrollView(
//   child: Column(
//     children: <Widget>[
//       MonthlyView(),
//       Container(
//         width: double.infinity,
//         child: Card(
//           elevation: 5.0,
//           color: Colors.blueAccent,
//           child: Text('CHART'),
//         ),
//       ),
//       Card(
//         child: Container(
//             child: Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: <Widget>[
//             TextField(
//               decoration: InputDecoration(labelText: 'Title'),
//             ),
//             TextField(
//               decoration: InputDecoration(labelText: 'Amount'),
//             ),
//             FlatButton(
//               child: Text('Add Transaction'),
//               onPressed: onButtonPress,
//             )
//           ],
//         )),
//       ),
//       Column(
//           children: transactions.map((transaction) {
//         return Card(
//             child: Row(
//           children: <Widget>[
//             Container(
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.green),
//               ),
//               margin: EdgeInsets.all(15),
//               child: Text(
//                 transaction.amount.toString(),
//                 style: TextStyle(fontSize: 20, color: Colors.amber),
//               ),
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text(transaction.title),
//                 Text(transaction.category),
//               ],
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: <Widget>[
//                 Text(DateFormat.yMMMd().format(transaction.date))
//               ],
//             )
//           ],
//         ));
//       }).toList())
//     ],
//   ),
// ),
