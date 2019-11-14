import 'package:spending_tracker/Core/Constants/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spending_tracker/UI/Views/CreateCategoryView/CreateCategoryView.dart';
import '../../../Core/ViewModels/AppProvider.dart';
import '../../Widgets/CategoryViewWidget/CategoryCard.dart';
import '../../../Core/Constants/ColorPalette.dart';

class CategoryOverviewCard extends StatelessWidget {
  final SizeConfig sizeConfig = SizeConfig();
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
          Stack(alignment: Alignment.center, children: [
            Align(
              alignment: Alignment.center,
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
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(
                  Icons.add_circle_outline,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) {
                      return CreateCategoryView();
                    }),
                  );
                },
              ),
            )
          ]),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              child: GridView.count(
                crossAxisCount: 2,
                children: appProvider.userCategoryList.map((eachCategory) {
                  return CategoryCard(eachCategory);
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
