import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spending_tracker/Core/Constants/ColorPalette.dart';
import 'package:spending_tracker/Core/ViewModels/AppProvider.dart';
import 'package:spending_tracker/UI/Views/CreateCategoryView/CreateCategoryView.dart';
import 'package:spending_tracker/UI/Widgets/MonthlyViewWidget/CategoryCardSliver.dart';

class CategoryHorizontalScrollBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);

    return Column(
      children: <Widget>[
        Text(
          "Categories",
          style: TextStyle(fontSize: 28, color: greyCityLights, fontWeight: FontWeight.w600),
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
                        redChiGong,
                        orangeville,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.add),
                      Text(
                        "Add Category",
                        textScaleFactor: 1.0,
                        style: TextStyle(fontSize: 24),
                      ),
                    ],
                  ),
                ),
              )
            : Container(
                height: 200,
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(8),
                    itemCount: appProvider.userCategoryList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.all(15),
                        width: 200,
                        height: 200,
                        child: CategoryCardSliver(appProvider.userCategoryList[index]),
                      );
                    }),
              ),
      ],
    );
  }
}
