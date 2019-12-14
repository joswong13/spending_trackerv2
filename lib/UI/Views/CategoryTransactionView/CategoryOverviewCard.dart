import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spending_tracker/UI/Widgets/CategoryViewWidget/CategoryRowWidget.dart';
import '../../../Core/ViewModels/AppProvider.dart';

class CategoryOverviewCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppProvider appProvider = Provider.of<AppProvider>(context);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Theme.of(context).primaryColor, Colors.transparent],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.05, 0.25],
        ),
      ),
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
      child: Column(
        children: <Widget>[
          Center(
            child: Text(
              "Categories",
              textScaleFactor: 1,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: appProvider.userCategoryList.length,
              itemBuilder: (BuildContext contect, int index) {
                return CategoryRowWidget(appProvider.userCategoryList[index]);
              },
            ),
          )
        ],
      ),
    );
  }
}
