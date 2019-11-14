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
          //button
          buttonTheme: ButtonThemeData(
            buttonColor: primaryGreen,
          ),
          //card
          cardColor: darkGrey,
          //dialog
          dialogTheme: DialogTheme(
            titleTextStyle: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 0.87),
              fontSize: 24,
            ),
          ),
          //icon
          iconTheme: IconThemeData(
            color: Color.fromRGBO(255, 255, 255, 0.87),
          ),
          //mode
          brightness: Brightness.dark,
          primaryColor: primaryGreen,
          //scaffold
          scaffoldBackgroundColor: Color.fromRGBO(18, 18, 18, 1),
          //text
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
