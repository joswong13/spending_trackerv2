import 'package:spending_tracker/Core/Constants/ColorPalette.dart';
import 'package:spending_tracker/Core/Constants/IconsLibrary.dart';
import 'package:spending_tracker/Core/Models/Category.dart';
import 'package:spending_tracker/Core/ViewModels/AppProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Views/CategoryTransactionView/CategoryTransactionView.dart';
import 'package:auto_size_text/auto_size_text.dart';

class CategoryCardSliver extends StatelessWidget {
  // final String _category;
  //final int _index;
  // final Color _color1;
  // final Color _color2;

  final UserCategory _userCategory;

  ///The widget that displays the category, amount and also is rendered with a gradient given 2 colors.
  ///Clicking on this widget will use Navigator.push to go to the CategoryTransactionView.dart.
  CategoryCardSliver(this._userCategory);

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    //preload getListOfCategoryTransactions
    return InkWell(
      onTap: () {
        appProvider.categoryType = _userCategory.name;
        appProvider.getListOfCategoryTransactions().then((resp) async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (BuildContext context) {
              return CategoryTransactionView(appProvider.categoryUserTransactionList, _userCategory.name);
            }),
          );
        });
      },
      child: Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [colorsMap[_userCategory.colorOne], colorsMap[_userCategory.colorTwo]],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icons[_userCategory.icon]),
            Text(
              _userCategory.name,
              style: TextStyle(fontSize: 24),
            ),
            AutoSizeText(
              "\$" + appProvider.monthlyCategoryTotals[_userCategory.name].toString(),
              style: TextStyle(fontSize: 24),
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
