import 'package:spending_tracker/Core/Constants/ColorPalette.dart';
import 'package:spending_tracker/Core/Constants/IconsLibrary.dart';
import 'package:spending_tracker/Core/Models/Category.dart';
import 'package:spending_tracker/Core/ViewModels/AppProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spending_tracker/UI/Widgets/CommonWidgets/CommonFunctions.dart';
import '../../Views/CategoryTransactionView/CategoryTransactionView.dart';
import 'package:auto_size_text/auto_size_text.dart';

class CategoryRowWidget extends StatelessWidget {
  final UserCategory _userCategory;

  ///The widget that displays the category, amount and also is rendered with a gradient given 2 colors.
  ///Clicking on this widget will use Navigator.push to go to the CategoryTransactionView.dart.
  CategoryRowWidget(this._userCategory);

  ///Used to pass unit tests on null amount value.
  String defaultValueString(double amount) {
    if (amount == null) {
      amount = 0;
    }
    return amount.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);

    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: [materialColorMap[_userCategory.colorOne], materialColorMap[_userCategory.colorTwo]],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: InkWell(
        onTap: () {
          appProvider.categoryType = _userCategory.name;
          appProvider.getListOfCategoryTransactions().then((resp) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) {
                return CategoryTransactionView(appProvider.categoryUserTransactionList, _userCategory.name);
              }),
            );
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Icon(icons[_userCategory.icon]),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AutoSizeText(
                  upperCaseFirstLetter(_userCategory.name),
                  style: TextStyle(fontSize: 24),
                  maxLines: 1,
                ),
                appProvider.busy
                    ? AutoSizeText(
                        "\$ -",
                        style: TextStyle(fontSize: 24),
                        maxLines: 1,
                      )
                    : AutoSizeText(
                        "\$" + defaultValueString(appProvider.monthlyCategoryTotals[_userCategory.name]),
                        style: TextStyle(fontSize: 24),
                        maxLines: 1,
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
