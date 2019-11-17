import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spending_tracker/Core/Constants/ColorPalette.dart';
import 'package:spending_tracker/Core/ViewModels/AppProvider.dart';
import 'package:spending_tracker/UI/Views/CreateCategoryView/CreateCategoryView.dart';
import 'package:spending_tracker/UI/Widgets/CategoryViewWidget/CategoryCard.dart';

class CategoryHorizontalScrollBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Theme.of(context).primaryColor, darkGrey],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.1, 0.5],
        ),
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Categories",
            textScaleFactor: 1,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600, color: Colors.black),
          ),
          appProvider.userCategoryList.length == 0
              ? InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return CreateCategoryView();
                    }));
                  },
                  child: Container(
                    height: 175,
                    width: 175,
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        colors: [
                          primaryGreen,
                          primaryGreen,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.add,
                          color: Colors.black,
                        ),
                        Text(
                          "Add Category",
                          textScaleFactor: 1.0,
                          style: TextStyle(color: Colors.black, fontSize: 24),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(
                  height: 175,
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.all(8),
                      itemCount: appProvider.userCategoryList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.all(15),
                          width: 175,
                          height: 175,
                          child: CategoryCard(appProvider.userCategoryList[index]),
                        );
                      }),
                ),
        ],
      ),
    );
  }
}
